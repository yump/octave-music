#!/usr/bin/octave

% testgen - generate one noisy sample of test data for DOA estimation

% Usage:
% [sample] = testdata ( elements, wavvec, variance)

% elements is an 3xN vector containing the position of each array element

% wavvec is the 3xK wave vector of the incident wavefront, k*<x,y,z>,
% where k is the wavenumber and the vector is unit length.

% variance is the variance of the zero-mean gaussian noise added to the sample

function [sample] = testgen ( elements, wavvec, variance)
	sample = zeros([size(elements,2),size(wavvec,2)]);
	for sx = 1:size(wavvec,2)
		sample(:,sx) = elements' * wavvec(:,sx);
		sample(:,sx) = exp(i*sample(:,sx));
		rnoise = sqrt(variance) * randn(size(sample(:,sx)));
		inoise = sqrt(variance) * randn(size(sample(:,sx)));
		sample(:,sx) += rnoise + i*inoise;
	end
end

		
