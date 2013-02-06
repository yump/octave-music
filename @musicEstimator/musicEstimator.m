function [music] = musicEstimator(arraypar, samples)

        % arraypar is an 3xM matrix holding the antenna locations.
	% arraypar(:,i) is a 3-vector holding the <x,y,z> location,
	% in multiples of the wave number, of the ith antenna.

	% samples is an Mx1 complex vector holding the input data.

	music.samples = samples;
	music.arraypar = arraypar;
	assert( columns(arraypar) == rows(samples) );

	% fancier covariance estimator goes here
	music.covar = zeros(rows(samples));
	for ix = 1:columns(samples)
		music.covar += samples(:,ix) * samples(:,ix)';
	endfor
	music.covar = music.covar / columns(samples);

	% get ordered eigenvals/vecs
	[vec, val] = eig(music.covar);
	[mag_ordered, ix] = sort(abs(sum(val)));
	music.eigval = diag(sum(val)(ix));
	music.eigvec = vec(:,ix);

	% Try to guess the dimension of the noise space
	music.noisedim = min( find( diff(mag_ordered) > 0.5 ) ); %emperical
	music.noisedim = rows(samples) - 2;

	% slice the noise space
	music.noisespace = music.eigvec(:,1:music.noisedim);

	music = class(music, "musicEstimator");

endfunction
