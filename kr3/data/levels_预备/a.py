import os

folder = r"D:\xj\steam\steamapps\common\Kingdom Rush Alliance\FL-电脑端可解压直玩，手机端请见手机安装教程\kr3\data\levels_预备"   # 目录路径，可以改成你的目标目录

for filename in os.listdir(folder):
    if filename.endswith(".exo3"):
        old_path = os.path.join(folder, filename)
        new_name = filename[:-5] + ".lua"
        new_path = os.path.join(folder, new_name)

        os.rename(old_path, new_path)
        print(f"{filename} -> {new_name}")

print("完成")