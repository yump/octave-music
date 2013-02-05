#!/usr/bin/octave

% Matrix of antenna positions for a 3x3 planar array in X-Z, 10 cm separation

% wave vectors, 2450 MHz.
k = 2*pi;

antennas = [
	0  1  1
	0  0  1
	0 -1  1
	0  1  0
	0  0  0
	0 -1  0
	0  1 -1
	0  0 -1
	0 -1 -1
];
antennas = antennas';


s1 = [-1 0 0]';                        %straight on
s2 = [-0.099015 -0.990148 -0.099015]'; %a little caddycorner from octant 1

sample = testgen(antennas, s1, 0.0076154); % 5 degree std dev

estimator = musicEstimator(antennas, sample);
abs(pmu(estimator, s1))
abs(pmu(estimator, [0 1 0]'))

tic;
spectrum =  abs(  pseudospec(estimator, pi/4, pi/4, 128, 128) );
toc;

mesh(spectrum);

%imwrite(imadjust(spectrum,stretchlim(spectrum,[0,1])), "spectrum.png");



