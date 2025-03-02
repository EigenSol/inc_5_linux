mv project/.env .
mkdir -p tmp/
zip -r tmp/project.zip project &>/dev/null
mv .env project
echo "Done"