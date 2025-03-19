import os
import ctypes
import gdown

# Hàm lấy đường dẫn Desktop chính xác
def get_desktop_path():
    CSIDL_DESKTOP = 0
    buf = ctypes.create_unicode_buffer(260)
    ctypes.windll.shell32.SHGetFolderPathW(None, CSIDL_DESKTOP, None, 0, buf)
    return buf.value

desktop_path = get_desktop_path()  # Lấy đường dẫn Desktop thật sự
root_folder = os.path.join(desktop_path, "Datasets")


# Định nghĩa danh sách thư mục và link (link là Google Drive folder)
mp = {
    "ML": "https://drive.google.com/drive/folders/1IYbwt4j2243SQB5f3Jc9obcHC_PmimGj",
    "CV": "https://drive.google.com/drive/folders/1SK4GwKcXTCmAM5Pp7hy8GuUmsLMeiDoY",
    "NLP": "https://drive.google.com/drive/folders/1GhwEsRp2YvoAgxOET_hJPBOh2G_14k4f",
}

# Tạo thư mục gốc nếu chưa tồn tại
os.makedirs(root_folder, exist_ok=True)

# Duyệt qua từng thư mục và tải về toàn bộ nội dung
for folder_name, drive_link in mp.items():
    target_folder = os.path.join(root_folder, folder_name)
    os.makedirs(target_folder, exist_ok=True)
    
    # Tải toàn bộ thư mục từ Google Drive
    print(f"Dang tai thu muc {folder_name} về {target_folder}")
    gdown.download_folder(drive_link, output=target_folder, quiet=False)
    print(f"Da tai xong {folder_name} về {target_folder}")