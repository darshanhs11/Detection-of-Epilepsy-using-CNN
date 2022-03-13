function wavef = wav_feat(y)

[c,l] = wavedec(y,4,'db4');
approx = appcoef(c,l,'db4');
[cd1,cd2,cd3,cd4] = detcoef(c,l,[1 2 3 4]);
[max_c, min_c, mean_c, std_c] = deal(zeros(1,5));

[max_c(:)] = [max(approx(:)),max(cd1(:)),max(cd2(:)),max(cd3(:)),max(cd4(:))];
[min_c(:)] = [min(approx(:)),min(cd1(:)),min(cd2(:)),min(cd3(:)),min(cd4(:))];
[mean_c(:)] = [mean(approx(:)),mean(cd1(:)),mean(cd2(:)),mean(cd3(:)),mean(cd4(:))];
[std_c(:)] = [std(approx(:)),std(cd1(:)),std(cd2(:)),std(cd3(:)),std(cd4(:))];

wavef = [max_c, min_c, mean_c, std_c];

end