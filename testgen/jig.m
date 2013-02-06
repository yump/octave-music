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
azi = pi/8*(rand-0.5);
elev = pi/8*(rand-0.5);
s2 = -[cos(azi).*cos(elev), sin(azi).*cos(elev), sin(elev)]';

numsamples = 2
sample1 = testgen(antennas, repmat(s1,[1,numsamples]), 0.00076154);
sample2 = testgen(antennas, repmat(s2,[1,numsamples]), 0.00076154);
sample = sample1 + sample2;

estimator = musicEstimator(antennas, sample);
abs(pmu(estimator, s1))
abs(pmu(estimator, [0 1 0]'))

tic;
spectemp = pseudospec(estimator, pi/4, pi/4, 128, 128);
toc;

spectrum = abs(spectemp);

mesh(spectrum);

%imwrite(imadjust(spectrum,stretchlim(spectrum,[0,1])), "spectrum.png");



