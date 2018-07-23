%Bir sýnýf daha ekleyeli
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
% grid on;% #1 bitiþ gscatter ile ayný iþ yaptýðý için kaldýrdýk burayý

%KNN YE GORE SINIFLANDIRMA ISLEMI YAPACAGIZ
tumSiniflar=[sinif1;sinif2,sinif3];%tüm sýnýflarý birleþtirdik
tumEtiketler=[etiket1;etiket2,etiket3];%tüm etiketleri birleþtirdik

model = fitcknn(tumSiniflar,tumEtiketler,'NumNeighbors',5);
%workspaceye model yazýp enterle. model hakkýnda bilgilere ulas
%mesela grafikte bi nokta seçip model üzerindeki etiketini görmeye
%calisalim workspaceye predict(model,[5,4]) yazýp hangi etikete sahip
%olduðunu görebiliriz. 

[x,y]=meshgrid(0:0.01:10); %0-10 aralýðýnda x y noktalarý olusturalým. Toplamda 11 tane nokta olusacak
etiketp = predict(model,[x(:),y(:)]);%x ve y noktalarýnn etiketlerini tahmin ettik.
gscatter(x(:),etiketp,'ycm','...');%belirlediðimiz x y noktalarý için etiket yerlerini belirledik

hold on;
gscatter(tumSiniflar(:,1),tumEtiketler(:,2),'rb','+*o'); %#1 ile ayný islemi yapýyor aslýnda
hold off; 
axis([0,10,0,10]);
grid on;

%#1

yetiket=predict(model, tumSiniflar); %modelimize eðittimiz verileri tekrar modele veriyorum , ayný verilerin bakalým
%tüm etiketlerini bulabilecekmiyiz? 

sum(yetiket==tumEtiketler)/length(yetiket)*100 ; %100 ile çarpýp yüzelik oraný buluyoruz
%k yý deðiþtirerek dene