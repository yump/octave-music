function [music] = musicEstimator(arraypar, samples, nsignals=0)

	% arraypar is an 3xM matrix holding the antenna locations.
	% arraypar(:,i) is a 3-vector holding the <x,y,z> location,
	% in multiples of the wave number, of the ith antenna.

	% samples is an MxK complex vector holding the input data, where K 
	% is the number of samples.

	music.samples = samples;
	music.arraypar = arraypar;
	assert( size(arraypar,2) == size(samples,1) );

	% future fancier covariance estimator goes here
	music.covar = samples * samples' / size(samples,2);

	% get ordered eigenvals/vecs
	[vec, val] = eig(music.covar);
	[mag_ordered, ix] = sort(abs(sum(val)));
	eiglist = sum(val); %two-step for MATLAB compatibility.
	music.eigval = diag(eiglist(ix));
	music.eigvec = vec(:,ix);

	if nsignals == 0
		% Try to guess the dimension of the noise space
		[~, music.noisedim] = max(diff(log(mag_ordered)));
		music.signals = size(samples,1) - music.noisedim;
	else
		music.noisedim = size(samples,1) - nsignals;
		music.signals = nsignals;
	end
	% DEBUG: figure for examining the eigenvalues
	figure(1);
	stem(log(mag_ordered));

	% slice the noise space
	music.noisespace = music.eigvec(:,1:music.noisedim);

	% debug
%	printf('\nSize of noise space\n');
%	size(music.noisespace)
%
%	printf('\nrank of noise space\n');
%	rank(music.noisespace)
%
%	printf('\nSize of covariance estiamte\n');
%	size(music.covar)
%
%	printf('\nrank of covariance estiamte\n');
%	rank(music.covar)

	music = class(music, 'musicEstimator');

end
