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
%antennas = antennas' ./8;

load circtennas.dat
antennas = antennas*0.4;


s1 = [-1 0 0]';                        %straight on
s3 = -sph2cart([pi/4*(rand - 0.5), pi/4*(rand -0.5), 1])';
s2 = -sph2cart([pi/4*(rand - 0.5), pi/4*(rand -0.5), 1])';
s4 = -sph2cart([pi/4*(rand - 0.5), pi/4*(rand -0.5), 1])';

%rotating signal
th = pi/8;
rot = [cos(th) -sin(th) 0; sin(th) cos(th) 0; 0 0 1];
if ( ! exist('s5') )
	s5 = s1;
	disp('Created s5');
end
s5 = rot*s5;
%cart2sph(s5')

numsamples = 1;
snr=60;
sample1 = testgen(antennas, repmat(s1,[1,numsamples]), snr);
sample2 = testgen(antennas, repmat(s2,[1,numsamples]), snr);
sample3 = testgen(antennas, repmat(s3,[1,numsamples]), snr);
sample4 = testgen(antennas, repmat(s4,[1,numsamples]), snr);
sample5 = testgen(antennas, repmat(s5,[1,numsamples]), snr);
sample = sample2;
%sample = sample2;

estimator = musicEstimator(antennas, sample);

%tic;
%spectemp = pseudospec(estimator, 2*pi, pi/2, 132, 128);
%toc;
%
%spectrum = abs(spectemp);

azi = linspace(-pi,pi,4);
elv = linspace(-pi/2,pi/2,4);
[aa,ee] = meshgrid(azi,elv);
tic;
spectrum = incident(estimator, aa, ee);
toc;

baselevel= 0.1;
prettyspectrum = imadjust(spectrum,stretchlim(spectrum,0)) + baselevel;

[xx, yy, zz] = sph2cart(aa,ee,prettyspectrum);
figure(2);
surf(xx,yy,zz);
axis([-1 1 -1 1 -1 1]*(1+baselevel));
xlabel('x');
ylabel('y');
zlabel('z');
print('sphere.eps');

figure(3);
mesh(aa,ee,spectrum);
xlabel('azimuth');
ylabel('elevation');
print('planar.eps')

disp('Attempting to find DOA');
t = cputime;
doa = doasearch(estimator,[-pi/2 pi/2 -pi/2 pi/2]);
t = cputime - t;
printf('Took %f seconds of CPU time\n',t);
realdoa = (cart2sph(-s2')(1:2))';
err = doa - realdoa;
lsqerr = log10(sqrt(sum(err.^2)));
printf('Approximte distance error is 10^%f\n',lsqerr);
printf('Absolute error is\n');
err

imwrite(imadjust(spectrum,stretchlim(spectrum,[0,1])), "spectrum.png");


