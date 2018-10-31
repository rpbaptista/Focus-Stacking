function siftMatch(im1,im2);
    [fa,da] = vl_sift(im2single(rgb2gray(im1))) ;
    [fb,db] = vl_sift(im2single(rgb2gray(im2))) ;

    [matches, scores] = vl_ubcmatch(da,db) ;

    [drop, perm] = sort(scores, 'descend') ;
    matches = matches(:, perm) ;
    scores  = scores(perm) ;

    figure(1) ; clf ;
    imagesc(cat(2, Ia, Ib)) ;
    axis image off ;
    vl_demo_print('sift_match_1', 1) ;

    figure(2) ; clf ;
    imagesc(cat(2, Ia, Ib)) ;

    xa = fa(1,matches(1,:)) ;
    xb = fb(1,matches(2,:)) + size(Ia,2) ;
    ya = fa(2,matches(1,:)) ;
    yb = fb(2,matches(2,:)) ;

    hold on ;
    h = line([xa ; xb], [ya ; yb]) ;
    set(h,'linewidth', 1, 'color', 'b') ;

    vl_plotframe(fa(:,matches(1,:))) ;
    fb(1,:) = fb(1,:) + size(Ia,2) ;
    vl_plotframe(fb(:,matches(2,:))) ;
    axis image off ;
    vl_demo_print('sift_match_2', 1) ;

end