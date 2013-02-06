function [result] = incident (music, azi, elev)
	
	assert (size(azi) == size(elev));

	propvec = zeros( [3,size(azi)] ); %oppan vector style
	propvec(1,:,:) = -cos(azi).*cos(elev);
	propvec(2,:,:) = -sin(azi).*cos(elev);
	propvec(3,:,:) = -sin(elev);
	
	result = pmu(music, propvec);

endfunction
