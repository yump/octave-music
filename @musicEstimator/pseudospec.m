function [result] = pseudospec (music, azi, elev, ares, eres)

	a = linspace(-azi/2, azi/2, ares);
	e = linspace(-elev/2, elev/2, eres);

	[aa,ee] = meshgrid(a,e);
	result = incident(music,aa,ee);

endfunction
