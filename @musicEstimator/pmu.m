function [result] = pmu(music, propvec)

	% propvec is a 3xLarge matrix holding unit vectors from the 
	% dirctions of interest.  (FROM the directions, remember.)

	a = exp( i .* (music.arraypar' * propvec) );

	result = 1 ./ ( a' * music.noisespace * music.noisespace' * a );

endfunction
