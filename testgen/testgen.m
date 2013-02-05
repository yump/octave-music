#!/usr/bin/octave

% testgen - generate one noisy sample of test data for DOA estimation

% Usage:
% [sample] = testdata ( elements, wavvec, variance)

% elements is an 3xN vector containing the position of each array element

% wavvec is the 3x1 wave vector of the incident wavefront, k*<x,y,z>,
% where k is the wavenumber and the vector is unit length.

% variance is the variance of the zero-mean gaussian noise added to the sample

function [sample] = testgen ( elements, wavvec, variance)
	sample = elements' * wavvec;
	sample += sqrt(variance) * randn(size(sample));
	sample = exp(i*sample);
end

		
