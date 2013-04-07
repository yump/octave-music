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


load circtennas.dat
antennas = antennas * 2; %radius 2
front = antennas;
back = antennas;
front(1,:) = 1;
back(1,:) = -1;
antennas = [front antennas back];


s1 = [-1 0 0]';                        %straight on
s3 = -sph2cart([pi/4*(rand - 0.5), pi/4*(rand -0.5), 1])';
s2 = -sph2cart([pi/4*(rand - 0.5), pi/4*(rand -0.5), 1])';
s4 = -sph2cart([pi/4*(rand - 0.5), pi/4*(rand -0.5), 1])';

%rotating signal
th = pi/16;
rot = [cos(th) -sin(th) 0; sin(th) cos(th) 0; 0 0 1];
if ( ! exist('s5') )
	s5 = s1;
	disp('Created s5');
end
s5 = rot*s5;
%cart2sph(s5')

numsamples = 16;
snr=20;
sample1 = testgen(antennas, s1, numsamples, snr);
sample2 = testgen(antennas, s2, numsamples, snr);
sample3 = testgen(antennas, s3, numsamples, snr);
sample4 = testgen(antennas, s4, numsamples, snr);
sample5 = testgen(antennas, s5, numsamples, snr);
sample = sample5 + sample1;

estimator = musicEstimator(antennas, sample, 2);

