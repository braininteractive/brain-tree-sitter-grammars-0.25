os_info:
    @echo "{{os()}} on {{arch()}}"

hashfile file:
    @echo {{sha256_file(file)}}
