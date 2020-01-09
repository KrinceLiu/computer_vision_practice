% Q3.3.1
clear all;
close all;

cv_img = imread('../data/cv_cover.jpg');
book_mov = loadVid('../data/book.mov');
source_mov = loadVid('../data/ar_source.mov');
video_frame = min(size(book_mov,2),size(source_mov,2));
result_mov = book_mov(1:video_frame);

for f = 1:video_frame

    %get sample
    sample_book_mov = book_mov(f).cdata;
    sample_source_mov = source_mov(f).cdata;
    sample_source_mov = sample_source_mov(60:300, 120:240,:);
    %feature extraction
    [locs1, locs2] = matchPics(cv_img, sample_book_mov);
    disp(size(locs1));
    %get H
    [bestH2to1, ~] = computeH_ransac(locs1, locs2);
    desk2cover = bestH2to1;
    cover2desk = inv(desk2cover);
    %scale
    scaled_sample_source_mov = imresize(sample_source_mov, [size(cv_img,1) size(cv_img,2)]);
    %implement
    result_mov(f).cdata = compositeH(cover2desk, scaled_sample_source_mov, sample_book_mov);

end

video_object = VideoWriter('../results/ar.avi');
video_object.FrameRate = 20;
open(video_object);
for i = 1:video_frame
   writeVideo(video_object,result_mov(i).cdata);
end
close(video_object );