#!/usr/bin/octave

% Matrix of antenna positions for a 3x3 planar array in Y-Z, wl/8 separation


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
antennas = antennas' ./8;


s1 = [-1 0 0]';                        %straight on
s3 = sph2cart([pi/2*(rand - 0.5), pi/2*(rand -0.5), 1])';
s2 = sph2cart([pi/2*(rand - 0.5), pi/2*(rand -0.5), 1])';
s4 = sph2cart([pi/2*(rand - 0.5), pi/2*(rand -0.5), 1])';

numsamples = 1;
noise = 0.0005;
sample1 = testgen(antennas, repmat(s1,[1,numsamples]), noise);
sample2 = testgen(antennas, repmat(s2,[1,numsamples]), noise);
sample3 = testgen(antennas, repmat(s3,[1,numsamples]), noise);
sample4 = testgen(antennas, repmat(s4,[1,numsamples]), noise);
sample = sample1 + sample2;
%sample = sample2;

estimator = musicEstimator(antennas, sample);
abs(pmu(estimator, s1))
abs(pmu(estimator, [0 1 0]'))

%tic;
%spectemp = pseudospec(estimator, 2*pi, pi/2, 128, 128);
%toc;
%
%spectrum = abs(spectemp);

th = linspace(-pi/2,pi/2,64);
ph = linspace(-pi,pi,64);
[tt,pp] = meshgrid(th,ph);
tic;
spectrum = incident(estimator, tt, pp);
toc;

%[xx, yy, zz] = sph2cart(tt,pp,spectrum);
figure(2);
mesh(spectrum);
print("spectrum.eps")

imwrite(imadjust(spectrum,stretchlim(spectrum,[0,1])), "spectrum.png");



