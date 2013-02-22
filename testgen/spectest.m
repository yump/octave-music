#!/usr/bin/octave 

% test the MUSIC spectrum visualization

shared %shared test components

azi = linspace(-pi,pi,64);
elv = linspace(-pi/2,pi/2,64);
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

imwrite(imadjust(spectrum,stretchlim(spectrum,[0,1])), "spectrum.png");


