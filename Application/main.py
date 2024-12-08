with open("test_results.json", "r", encoding='utf-8') as f:
    content = f.read()

with open("test_results.json", "w", encoding="utf-8") as f:
    f.write(content)