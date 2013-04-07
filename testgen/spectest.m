#!/usr/bin/octave 

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


