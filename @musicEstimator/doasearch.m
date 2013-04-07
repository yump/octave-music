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

function [result] = doasearch ( music, domain )
	if (music.signals > 1)
		disp('WARNING: doasearch only handles the 1 signal case');
	end

	domsz = 16;
	its = 8;
	result = zeros(2,1);

	amin = domain(1);
	amax = domain(2);
	emin = domain(3);
	emax = domain(4);

	for ix = 1:its

		azi = linspace(amin,amax,domsz);
		elv = linspace(emin,emax,domsz);
		aeps = azi(2)-azi(1);
		eeps = elv(2)-elv(1);
		[aa,ee] = meshgrid(azi,elv);
		
		spectrum = incident(music,aa,ee);
		[~,ind] = max(spectrum(:));
		[r,c] = ind2sub([domsz,domsz],ind);
		
		amax = azi(c) + 2*aeps;
		amin = azi(c) - 2*aeps;
		emax = elv(r) + 2*eeps;
		emin = elv(r) - 2*eeps;

		result(1) = azi(c);
		result(2) = elv(r);

	end
	%debug
	finalwindow = [amax - amin, emax - emin]'


end
