function [result] = incident (music, azi, elev)

	propvec = -[cos(azi).*cos(elev), sin(azi).*cos(elev), sin(elev)]';
	result = pmu(music, propvec);

endfunction
