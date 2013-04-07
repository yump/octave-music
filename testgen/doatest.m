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


% Test the iterative DOA finding function

shared %shared test components

disp('Attempting to find DOA');
t = cputime;
doa = doasearch(estimator,[-pi/2 pi/2 -pi/2 pi/2]);
t = cputime - t;
printf('Took %f seconds of CPU time\n',t);
realdoa = cart2sph(-s2');
realdoa = realdoa(1:2)';
err = doa - realdoa;
lsqerr = log10(sqrt(sum(err.^2)));
printf('Approximte distance error is 10^%f\n',lsqerr);
printf('Absolute error is\n');
err

