function [music] = musicEstimator(arraypar, samples)

        % arraypar is an 3xM matrix holding the antenna locations.
	% arraypar(:,i) is a 3-vector holding the <x,y,z> location,
	% in multiples of the wave number, of the ith antenna.

	% samples is an Mx1 complex vector holding the input data.

	music.samples = samples;
	music.arraypar = arraypar;
	assert( size(arraypar,2) == size(samples,1) );

	% fancier covariance estimator goes here
	music.covar = zeros(size(samples,1));
	for ix = 1:size(samples,2)
		music.covar = music.covar + samples(:,ix) * samples(:,ix)';
	end
	music.covar = music.covar / size(samples,2);

	% get ordered eigenvals/vecs
	[vec, val] = eig(music.covar);
	[mag_ordered, ix] = sort(abs(sum(val)));
	eiglist = sum(val); %two-step for MATLAB compatibility.
	music.eigval = diag(eiglist(ix));
	music.eigvec = vec(:,ix);

	% Try to guess the dimension of the noise space
	[~, music.noisedim] = max(diff(log(mag_ordered)));
	music.signals = size(samples,1) - music.noisedim;
	%music.noisedim = rows(samples) - 1;
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
