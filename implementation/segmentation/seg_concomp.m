function [ merged ] = seg_concomp( A )
    se = strel('disk',3);
    
    closed = imclose(imcomplement(A),se);
    CC = bwconncomp(closed);
    merged = seg_merge_groups(CC.PixelIdxList, size(A)); 
    
end
