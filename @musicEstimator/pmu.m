function [result] = pmu(music, propvec)

	% propvec is a matrix holding unit vectors from the 
	% dirctions of interest.  (FROM the directions, remember.)

	insz = size(propvec);

	%printf("Size of propvec\n");
	%insz

	% single point case (propvec is 3x1)
	if ( (length(insz) == 2) && all(insz == [3 1]) )
		a = exp( i .* (music.arraypar' * propvec) );
		result = 1 ./ ( a' * music.noisespace * music.noisespace' * a );
	% multiple point case (propvec is MxNx3)
	elseif ( length(insz) == 3 && insz(3) == 3 )
		result = zeros(size(propvec)(1:2));
		propvec = permute(propvec,[3,2,1]); %faster memory access, no gathering
		for m = 1:size(propvec,3)
			for n = 1:size(propvec,2)
				a = exp( i .* (music.arraypar' * propvec(:,m,n)) );
				result(m,n) = 1 ./ ( a' * music.noisespace * music.noisespace' * a );
			end
		end
	else
		error("pmu: bad propvec size\n");
	end


endfunction
