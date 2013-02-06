function [result] = incident (music, azi, elev)
	
	assert (size(azi) == size(elev));

	propvec = zeros( [size(azi),3] ); %oppan color image style
	propvec(:,:,1) = -cos(azi).*cos(elev);
	propvec(:,:,2) = -sin(azi).*cos(elev);
	propvec(:,:,3) = -sin(elev);
	
	result = pmu(music, propvec);

endfunction
