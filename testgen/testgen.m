% testgen - generate one noisy sample of test data for DOA estimation

%   Copyright 2012,2013 Russell Haley
%   (Please add yourself if you make changes)
%
%   This file is part of doa-backend.
%
%   doa-backend is free software: you can redistribute it and/or modify
%   it under the terms of the GNU General Public License as published by
%   the Free Software Foundation, either version 3 of the License, or
%   (at your option) any later version.
%
%   doa-backend is distributed in the hope that it will be useful,
%   but WITHOUT ANY WARRANTY; without even the implied warranty of
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%   GNU General Public License for more details.
%
%   You should have received a copy of the GNU General Public License
%   along with doa-backend.  If not, see <http://www.gnu.org/licenses/>.

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
	phases = repmat(phases,1,num_samples);

	%necessary so that signals are uncorrelated
	modulation = rand(1,num_samples) - 0.5;
	phases = bsxfun(@plus,phases,modulation);

	samples = exp(i*(phases + rand*2*pi));
	samples = awgn(samples,snr);
end
