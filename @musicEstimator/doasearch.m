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
