ARTIFACTORY_URL="https://ncr.jfrog.io/artifactory"

REPO_NAME="<name of Repo"

EMAIL="<your email"

TOKEN="token number generated from the tool"

PATTERN="release/6.*"

ENDPOINT=$(curl -u $EMAIL:$TOKEN -X POST -H "Content-Type: text/plain"  --data-raw "items.find({\"repo\":\"$REPO_NAME\",\"path\":{\"\$match\":\"$PATTERN\"},\"name\":{\"\$match\":\"*SilverPro*.apk\"}}).sort({\"\$desc\":[\"created\"]}).limit(1)" "$ARTIFACTORY_URL"/api/search/aql | grep -E 'path|name' | awk '{print $3} ' | xargs | sed 's/ /\//g' | sed s/\"//g | sed s/,//g)

APK_PATH=$ARTIFACTORY_URL"/"$REPO_NAME"/"$ENDPOINT

mkdir -p "./apk"

echo "Downloading APK from "$APK_PATH

curl -u $EMAIL:$TOKEN -XGET "$APK_PATH" -o "./apk/SilverPro.apk"

echo "APK download completed"
