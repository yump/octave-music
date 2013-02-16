function display (music)

	printf('samples\n')
	music.samples

	printf('arraypar\n')
	music.arraypar

	printf('covar\n')
	music.covar

	printf('noisedim\n')
	music.noisedim

	printf('noisespace\n')
	music.noisespace

	printf('mag_ordered')
	abs(music.eigval)

end
