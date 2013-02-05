function [result] = pseudospec (music, azi, elev, ares, eres)

	aa = linspace(-azi/2, azi/2, ares);
	ee = linspace(-elev/2, elev/2, eres);

	result = zeros(eres,ares);
	for ax = 1:ares
		for ex = 1:eres
			result(ex,ax) = incident(music, aa(ax), ee(ex));
		endfor
	endfor

endfunction
