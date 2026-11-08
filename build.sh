docker buildx build \
     --progress=plain \
     -t technicalguru/mailserver-postfixadmin:latest \
     -t technicalguru/mailserver-postfixadmin:4.0.6.0 \
     -t technicalguru/mailserver-postfixadmin:4.0.6 \
     -t technicalguru/mailserver-postfixadmin:4.0 \
     -t technicalguru/mailserver-postfixadmin:4 \
     --push \
     --platform linux/amd64,linux/arm64 \

#docker build --progress=plain -t technicalguru/mailserver-postfixadmin:latest .
