yc compute instance create \
  --name reddit-app-1 \
  --hostname reddit-app-1 \
  --memory=4 \
  --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --metadata-from-file user-data=metadata.yml \
  --metadata serial-port-enable=1
