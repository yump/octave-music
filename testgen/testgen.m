% testgen - generate one noisy sample of test data for DOA estimation

% Usage:
% [sample] = testdata ( elements, wavvec, snr)

% elements is an 3xN vector containing the position of each array element

% wavvec is the 3x1 wave vector of the incident wavefront, k*<x,y,z>,
% where k is the wavenumber and the vector is unit length.
% num_samples is the number of samples
% snr is the signal/noise ratio

function [samples] = testgen ( elements, wavvec, num_samples, snr)
	samples = zeros([size(elements,2),size(wavvec,2)]);
	phases = elements' * wavvec;
	iq = exp(i*(phases + rand*2*pi));
	samples = repmat(iq,1,num_samples);

	for ex = 1:size(elements,2)
		samples(ex,:) = awgn(samples(ex,:),snr);
	end
end
