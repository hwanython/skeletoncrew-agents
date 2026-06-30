#!/usr/bin/env python3
"""현재 설치된 스킬·플러그인 카탈로그를 스냅샷해서 manifest 로 저장한다.
타임스탬프를 넣지 않으므로, 카탈로그가 실제로 바뀔 때만 git diff 가 생긴다.
=> '에이전트의 도구 인식'이 어느 시점에 머무는지를 git 이력으로 추적할 수 있다."""
import json, os, re, sys, hashlib

HOME = os.path.expanduser("~")
SKILLS_DIR = os.path.join(HOME, ".claude", "skills")
PLUGINS_DIR = os.path.join(HOME, ".claude", "plugins")
REPO = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
OUT = os.path.join(REPO, "sources", "manifests", "skills-manifest.json")

FM = re.compile(r"^---\s*$")

def read_frontmatter(path):
    """SKILL.md 의 아주 단순한 YAML 프론트매터에서 name/description 만 뽑는다."""
    try:
        with open(path, encoding="utf-8") as f:
            lines = f.read().splitlines()
    except Exception:
        return {}
    if not lines or not FM.match(lines[0]):
        return {}
    out, i = {}, 1
    while i < len(lines) and not FM.match(lines[i]):
        m = re.match(r"^(name|description|version)\s*:\s*(.*)$", lines[i])
        if m:
            out[m.group(1)] = m.group(2).strip().strip('"').strip("'")
        i += 1
    return out

def scan_skill_dirs(root, source):
    found = []
    if not os.path.isdir(root):
        return found
    for entry in sorted(os.listdir(root)):
        sk = os.path.join(root, entry, "SKILL.md")
        if os.path.isfile(sk):
            fm = read_frontmatter(sk)
            found.append({
                "name": fm.get("name", entry),
                "description": fm.get("description", ""),
                "source": source,
            })
    return found

def load_plugins():
    p = os.path.join(PLUGINS_DIR, "installed_plugins.json")
    out = []
    if os.path.isfile(p):
        data = json.load(open(p, encoding="utf-8"))
        for key, insts in data.get("plugins", {}).items():
            ver = insts[0].get("version") if insts else None
            out.append({"name": key, "version": ver})
    return sorted(out, key=lambda x: x["name"])

def main():
    skills = scan_skill_dirs(SKILLS_DIR, "gstack/local")
    # 플러그인 내부 SKILL.md 도 훑는다(있으면)
    for mp in ("marketplaces", "cache"):
        base = os.path.join(PLUGINS_DIR, mp)
        if os.path.isdir(base):
            for dirpath, _, files in os.walk(base):
                if "SKILL.md" in files:
                    fm = read_frontmatter(os.path.join(dirpath, "SKILL.md"))
                    if fm.get("name"):
                        skills.append({"name": fm["name"],
                                       "description": fm.get("description", ""),
                                       "source": "plugin"})
    # 이름 기준 dedupe
    seen, uniq = set(), []
    for s in sorted(skills, key=lambda x: x["name"]):
        if s["name"] in seen:
            continue
        seen.add(s["name"]); uniq.append(s)

    plugins = load_plugins()
    names_blob = "\n".join(s["name"] for s in uniq) + "\n" + "\n".join(p["name"] for p in plugins)
    manifest = {
        "skillCount": len(uniq),
        "pluginCount": len(plugins),
        "catalogHash": hashlib.sha256(names_blob.encode()).hexdigest()[:16],
        "skills": uniq,
        "plugins": plugins,
    }
    os.makedirs(os.path.dirname(OUT), exist_ok=True)
    with open(OUT, "w", encoding="utf-8") as f:
        json.dump(manifest, f, ensure_ascii=False, indent=2)
        f.write("\n")
    print(f"  스킬 {len(uniq)}개 · 플러그인 {len(plugins)}개 · hash {manifest['catalogHash']}")
    print(f"  → {os.path.relpath(OUT, REPO)}")

if __name__ == "__main__":
    main()
