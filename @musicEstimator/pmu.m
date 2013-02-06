function [result] = pmu(music, propvec)

	% propvec is a matrix holding unit vectors from the 
	% dirctions of interest.  (FROM the directions, remember.)

	insz = size(propvec);
	noisetemp = music.noisespace * music.noisespace'; %subexp
	arraypartemp = music.arraypar';

	% single point case (propvec is 3x1)
	if ( (length(insz) == 2) && all(insz == [3 1]) )
		a = exp( i .* (arraypartemp * propvec) );
		result_inv = ( a' * noisetemp * a );

	% multiple point case (propvec is 3xMxN)
	elseif ( length(insz) == 3 && insz(1) == 3 )
		result_inv = zeros(size(propvec)(1:2));

		for n = 1:size(propvec,3)
			for m = 1:size(propvec,2)
				a = exp( i * (arraypartemp * propvec(:,m,n)) );
				result_inv(m,n) = ( a' * noisetemp * a );
			end
		end

	else
		error("pmu: bad propvec size\n");
	end

	result = 1 ./ abs(result_inv);


endfunction
