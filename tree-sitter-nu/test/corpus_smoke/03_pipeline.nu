ls | where size > 1kb | sort-by modified | select name size | first 5
