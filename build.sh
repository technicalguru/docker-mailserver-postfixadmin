docker buildx build \
     --progress=plain \
     -t technicalguru/mailserver-postfixadmin:latest \
     -t technicalguru/mailserver-postfixadmin:3.3.16.0 \
     -t technicalguru/mailserver-postfixadmin:3.3.16 \
     -t technicalguru/mailserver-postfixadmin:3.3 \
     -t technicalguru/mailserver-postfixadmin:3 \
     --push \
     --platform linux/amd64,linux/arm64 \

#docker build --progress=plain -t technicalguru/mailserver-postfixadmin:latest .
