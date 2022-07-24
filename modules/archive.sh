# This module contains functions to manipulate archives. 

# Takes an archive and splits into 90M. 
	# This is due to size contraints on GitHub. 
	# Args:
		# - $1: name and location of the archive to be split
		# - $2: name and location where splitted archive is to be saved
	# Source: https://superuser.com/questions/336219/how-do-i-split-a-zip-file-into-multiple-segments#:~:text=Add%20a%20comment-,3%20Answers,-Sorted%20by%3A
function split_archive() { original_archive=$1; new_decomposed_archive=$2
	title "Splitting Archive"

	zip "$original_archive" --out "$new_decomposed_archive" -s 90m
}

# Reconstructs archive which was previously split. 
	# Args:
		# - $1: name and location of decomposed archive
		# - $2: name and location of archive to be reconstructed
	# Source: https://superuser.com/questions/336219/how-do-i-split-a-zip-file-into-multiple-segments#:~:text=Add%20a%20comment-,3%20Answers,-Sorted%20by%3A
function reconstruct_archive() { decomposed_archive=$1; reconstruct_archive=$2
	title "Recontructing Archive"    

	zip -F "$decomposed_archive" --out "$reconstruct_archive"
}

# Compresses a directory into an archive. 
	# Args:
		# - $1: name and location of archive to be created
		# - $2: name and location of target to be archived
	# Source: https://superuser.com/questions/336219/how-do-i-split-a-zip-file-into-multiple-segments#:~:text=Add%20a%20comment-,3%20Answers,-Sorted%20by%3A
function compress_archive() { archive_name=$1; target=$2
	title "Compress Archive"

	zip -r "$archive_name" "$target"
}

# Uncompresses archive. 
	# Args:
		# - $1: name and location of archive to be uncompressed
		# - $2: location where archive is to be uncompressed to
	# Source: https://superuser.com/questions/336219/how-do-i-split-a-zip-file-into-multiple-segments#:~:text=Add%20a%20comment-,3%20Answers,-Sorted%20by%3A 
function uncompress_archive() {
	title "Uncompress Archive"

	archive=$1
	destination=$2

	unzip "$archive" -d "$destination"
}