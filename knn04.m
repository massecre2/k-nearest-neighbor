%Bir s�n�f daha ekleyeli
N1 = [2,3];
N2 = [5,7];
N3 = [7,8];

sinif1 = repmat(N1,100,1)+randn(100,2);
sinif2 = repmat(N2,100,1)+randn(100,2);
sinif3 = repmat(N3,100,1)+randn(100,2);


etiket1  = ones(100,1);
etiket2  = 2*ones(100,1);
etiket3  = 3*ones(100,1);


% plot3(sinif1(:,1),sinif1(:,2),etiket1-1, 'r+'); %#1
% hold on;
% plot3(sinif2(:,1),sinif2(:,2),etiket1-1, 'b*');
% hold off;
% axis([0,10,0,10]);
% grid on;% #1 biti� gscatter ile ayn� i� yapt��� i�in kald�rd�k buray�

%KNN YE GORE SINIFLANDIRMA ISLEMI YAPACAGIZ
tumSiniflar=[sinif1;sinif2,sinif3];%t�m s�n�flar� birle�tirdik
tumEtiketler=[etiket1;etiket2,etiket3];%t�m etiketleri birle�tirdik

model = fitcknn(tumSiniflar,tumEtiketler,'NumNeighbors',5);
%workspaceye model yaz�p enterle. model hakk�nda bilgilere ulas
%mesela grafikte bi nokta se�ip model �zerindeki etiketini g�rmeye
%calisalim workspaceye predict(model,[5,4]) yaz�p hangi etikete sahip
%oldu�unu g�rebiliriz. 

[x,y]=meshgrid(0:0.01:10); %0-10 aral���nda x y noktalar� olustural�m. Toplamda 11 tane nokta olusacak
etiketp = predict(model,[x(:),y(:)]);%x ve y noktalar�nn etiketlerini tahmin ettik.
gscatter(x(:),etiketp,'ycm','...');%belirledi�imiz x y noktalar� i�in etiket yerlerini belirledik

hold on;
gscatter(tumSiniflar(:,1),tumEtiketler(:,2),'rb','+*o'); %#1 ile ayn� islemi yap�yor asl�nda
hold off; 
axis([0,10,0,10]);
grid on;

%#1

yetiket=predict(model, tumSiniflar); %modelimize e�ittimiz verileri tekrar modele veriyorum , ayn� verilerin bakal�m
%t�m etiketlerini bulabilecekmiyiz? 

sum(yetiket==tumEtiketler)/length(yetiket)*100 ; %100 ile �arp�p y�zelik oran� buluyoruz
%k y� de�i�tirerek dene