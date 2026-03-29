import socket
import threading
import os

CONFIG_NAME = "rtspforward.conf"

def load_config():
    # First Read of File on the current dir
    if not os.path.exists(CONFIG_NAME):
        raise FileNotFoundError(f"Configuration file '{CONFIG_NAME}' not found in current directory.")

    # Init reading to retrieve DIRECTORY
    initial_config = {}
    with open(CONFIG_NAME, "r") as f:
        for line in f:
            line = line.strip()
            if not line or line.startswith("#"):
                continue
            if "=" in line:
                key, value = line.split("=", 1)
                initial_config[key.strip()] = value.strip()

    if "DIRECTORY" not in initial_config:
        raise ValueError("Missing DIRECTORY in configuration file.")

    directory = initial_config["DIRECTORY"]

    # Path built to the conf file
    config_path = os.path.join(directory, CONFIG_NAME)

    if not os.path.exists(config_path):
        raise FileNotFoundError(f"Configuration file not found at: {config_path}")

    # Full reading of conf file
    config = {}
    with open(config_path, "r") as f:
        for line in f:
            line = line.strip()
            if not line or line.startswith("#"):
                continue
            if "=" in line:
                key, value = line.split("=", 1)
                config[key.strip()] = value.strip()

    required = ["LISTEN_PORT", "TARGET_HOST", "TARGET_PORT"]
    for key in required:
        if key not in config:
            raise ValueError(f"Missing required config key: {key}")

    return (
        int(config["LISTEN_PORT"]),
        config["TARGET_HOST"],
        int(config["TARGET_PORT"])
    )


def forward(src, dst):
    try:
        while True:
            data = src.recv(4096)
            if not data:
                break
            dst.sendall(data)
    except:
        pass
    finally:
        try: src.close()
        except: pass
        try: dst.close()
        except: pass


def handle_client(client_socket, target_host, target_port):
    try:
        remote_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        remote_socket.connect((target_host, target_port))

        t1 = threading.Thread(target=forward, args=(client_socket, remote_socket))
        t1.start()

        t2 = threading.Thread(target=forward, args=(remote_socket, client_socket))
        t2.start()

    except Exception:
        client_socket.close()


def main():
    listen_port, target_host, target_port = load_config()

    server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server.bind(("0.0.0.0", listen_port))
    server.listen(5)

    print(f"Proxy TCP activated : 0.0.0.0:{listen_port} → {target_host}:{target_port}")

    while True:
        client_socket, addr = server.accept()
        t = threading.Thread(target=handle_client, args=(client_socket, target_host, target_port))
        t.start()


if __name__ == "__main__":
    main()
