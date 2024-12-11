FILE="uber-apk-signer.jar"
URL="https://github.com/patrickfav/uber-apk-signer/releases/download/v1.3.0/uber-apk-signer-1.3.0.jar"
APK_FILE="release.RE.apk"
PACKAGE="reflutter"

cat << "EOF"


o    o                      .oPYo. .oPYo.  d'b 8          o    o               
8b   8                      8   `8 8.      8   8          8    8               
8`b  8 .oPYo. .oPYo.       o8YooP' `boo   o8P  8 o    o  o8P  o8P .oPYo. oPYo. 
8 `b 8 8    8 8oooo8 ooooo  8   `b .P      8   8 8    8   8    8  8oooo8 8  `' 
8  `b8 8    8 8.            8    8 8       8   8 8    8   8    8  8.     8     
8   `8 `YooP8 `Yooo'        8    8 `YooP'  8   8 `YooP'   8    8  `Yooo' 8     
..:::..:....8 :.....::::::::..:::..:.....::..::..:.....:::..:::..::.....:..::::
:::::::::ooP'.:::::::::::::::::::::::::::::::::::::::::::::::Urip Kui Urup:::::
:::::::::...:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
EOF

if pip show "$PACKAGE" > /dev/null 2>&1; then
    echo "[+] $PACKAGE is installed."
else
    echo "[+] $PACKAGE is not installed. Installing..."
    pip install "$PACKAGE" --break-system-packages
    if [ $? -eq 0 ]; then
        echo "[+] $PACKAGE installed successfully."
    else
        echo "[+] Failed to install $PACKAGE. Exiting."
        exit 1
    fi
fi

if [ -z "$1" ]; then
    echo "[+] Usage: $0 <apk file>"
    exit 1
else
    echo "[+] Checking File $1 exists..."
    if [ -f "$1" ]; then
        echo "[+] File $1 exists."
        echo "[+] Running reflutter on $1..."
        reflutter $1
        if [ $? -eq 0 ]; then
            echo "[+] Successfully refluttered $1"
        else
            echo "[+] Failed to reflutter $1"
            exit 1
        fi
    else
        echo "[+] File $1 does not exist. Check your input."
        exit 1
    fi
fi

echo "[+] Checking $FILE exists..."

if [ -f "$FILE" ]; then
    echo "[+] $FILE exists."
else
    echo "[+] $FILE does not exist. Downloading..."
    curl -L -o "$FILE" "$URL"
    if [ $? -eq 0 ]; then
        echo "[+] Download complete: $FILE"
    else
        echo "[+] Failed to download $FILE. Check your internet connection or URL."
        exit 1
    fi
fi

echo "[+] Running uber-apk-signer..."
java -jar "$FILE" --apk "$APK_FILE" 

if [ $? -eq 0 ]; then
    echo "[+] Successfully signed $1"
    echo "[+] Wish you a happy hacking!"

else
    echo "[+] Failed to sign $1"
    exit 1
fi
