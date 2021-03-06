FasdUAS 1.101.10   ��   ��    k             l      ��  ��   ��
allow variables to be on any line of the note

	# DESCRIPTION
	
	This script looks for a Template folder and asks you to pick one of the templates within to create 
	an instance of. It then allows you to select a folder for the instance and to choose the desired values
	for any variables designated in the last paragraph of the project's note (by default, "$" before a word
	designates it as a variable, an ode to my favorite CSS preprocessor, SASS).
	
	Some other goodies:
		-	You can specify relative start or due dates (one or the other, not both� yet) for the project
			and/or each task individually. To do so, put a paragraph somewhere in the note of that item that
			starts with either "Due" or "Start". Then use the same natural language date syntax as you can usually
			use in OmniFocus/ my "Later" Applescript: things like "today + 2d", "2d", "3w 4d 2pm", etc., will all
			work as expected, hopefully. All of these will be relative to the date you run the script.
		-	Variables can be used in project names and notes, task names and notes, and task context names
		-	On the first run it detects if you have projects using Curt Clifton's OmniFocus template syntax
			(to which I owe a lot of the good ideas in this script) and offers to change it for you.
		-	It offers to show you the new instance of the template once it has populated the instance.
		-	Automagically changes the new project instance to "Active" if the template project was "On Hold"
	
	
	# LICENSE
	
	Use it, change it, enjoy it. Please don't blatently pass off my work as your own. Be cool.
	
	
	# INSTALLATION
	
	-	Copy this script to ~/Library/Scripts/Applications/Omnifocus (you may have to use the
		Go > Go to Folder� menu in your file navigation application of choice as the user library
		folder is hidden on Mac OS X 10.7+. After you select this menu item, type the path above and
		hit enter).
	-	If you prefer, you can have this script be activated by a utility like Keyboard Maestro or FastScripts
	
	
	# VERSION INFORMATION
		
		0.2.4 (January 22, 2013): Other bugfixes
		0.2.3 (January 22, 2013): Fix for setting default folder to a subfolder
		0.2.2 (January 22, 2013): Allows you to set both a start and due date. Fixes a bug where due/ start declarations
		in projects wouldn't be eliminated when a new instance was created.
		0.2.1 (January 22, 2013): Does a better job of cleaning up notes and allows variables on any line of project
		0.2 (January 21, 2013): using the keyword "ask" in after the start/due declaration in the note of a task/ project will have the
		script prompt you to enter a relative or absolute start/due date for that item. Similarly, you can use the keyword
		"project" to set the start/ due date relative to that of the project; the script will take whatever is
		after the keyword and subtract it from the due date/ add it to the start date of the project, as the
		case may be. Finally, using the (by default) ">>>" operator in the second, followed by a string that EXACTLY matches
		one of the folders in your OF library will skip the folder selection dialog and put the new instance
		directly in the designated folder. Plus, fancy icon.
		0.1.1 (January 18, 2013): Handles projects in a template folder without variables more gracefully (thanks, Sven!)
		0.1 (January 18, 2013): Initial release
		
	
	# BEING WORKED ON
	
	-	Using Growl for notifications if the user has it installed and running.
	
	
	# KNOWN ISSUES

	- 	Due/ Start date note sometimes stays in project after template is populated (seems to be when it is set to ask).
     � 	 	� 
 a l l o w   v a r i a b l e s   t o   b e   o n   a n y   l i n e   o f   t h e   n o t e 
 
 	 #   D E S C R I P T I O N 
 	 
 	 T h i s   s c r i p t   l o o k s   f o r   a   T e m p l a t e   f o l d e r   a n d   a s k s   y o u   t o   p i c k   o n e   o f   t h e   t e m p l a t e s   w i t h i n   t o   c r e a t e   
 	 a n   i n s t a n c e   o f .   I t   t h e n   a l l o w s   y o u   t o   s e l e c t   a   f o l d e r   f o r   t h e   i n s t a n c e   a n d   t o   c h o o s e   t h e   d e s i r e d   v a l u e s 
 	 f o r   a n y   v a r i a b l e s   d e s i g n a t e d   i n   t h e   l a s t   p a r a g r a p h   o f   t h e   p r o j e c t ' s   n o t e   ( b y   d e f a u l t ,   " $ "   b e f o r e   a   w o r d 
 	 d e s i g n a t e s   i t   a s   a   v a r i a b l e ,   a n   o d e   t o   m y   f a v o r i t e   C S S   p r e p r o c e s s o r ,   S A S S ) . 
 	 
 	 S o m e   o t h e r   g o o d i e s : 
 	 	 - 	 Y o u   c a n   s p e c i f y   r e l a t i v e   s t a r t   o r   d u e   d a t e s   ( o n e   o r   t h e   o t h e r ,   n o t   b o t h &   y e t )   f o r   t h e   p r o j e c t 
 	 	 	 a n d / o r   e a c h   t a s k   i n d i v i d u a l l y .   T o   d o   s o ,   p u t   a   p a r a g r a p h   s o m e w h e r e   i n   t h e   n o t e   o f   t h a t   i t e m   t h a t 
 	 	 	 s t a r t s   w i t h   e i t h e r   " D u e "   o r   " S t a r t " .   T h e n   u s e   t h e   s a m e   n a t u r a l   l a n g u a g e   d a t e   s y n t a x   a s   y o u   c a n   u s u a l l y 
 	 	 	 u s e   i n   O m n i F o c u s /   m y   " L a t e r "   A p p l e s c r i p t :   t h i n g s   l i k e   " t o d a y   +   2 d " ,   " 2 d " ,   " 3 w   4 d   2 p m " ,   e t c . ,   w i l l   a l l 
 	 	 	 w o r k   a s   e x p e c t e d ,   h o p e f u l l y .   A l l   o f   t h e s e   w i l l   b e   r e l a t i v e   t o   t h e   d a t e   y o u   r u n   t h e   s c r i p t . 
 	 	 - 	 V a r i a b l e s   c a n   b e   u s e d   i n   p r o j e c t   n a m e s   a n d   n o t e s ,   t a s k   n a m e s   a n d   n o t e s ,   a n d   t a s k   c o n t e x t   n a m e s 
 	 	 - 	 O n   t h e   f i r s t   r u n   i t   d e t e c t s   i f   y o u   h a v e   p r o j e c t s   u s i n g   C u r t   C l i f t o n ' s   O m n i F o c u s   t e m p l a t e   s y n t a x 
 	 	 	 ( t o   w h i c h   I   o w e   a   l o t   o f   t h e   g o o d   i d e a s   i n   t h i s   s c r i p t )   a n d   o f f e r s   t o   c h a n g e   i t   f o r   y o u . 
 	 	 - 	 I t   o f f e r s   t o   s h o w   y o u   t h e   n e w   i n s t a n c e   o f   t h e   t e m p l a t e   o n c e   i t   h a s   p o p u l a t e d   t h e   i n s t a n c e . 
 	 	 - 	 A u t o m a g i c a l l y   c h a n g e s   t h e   n e w   p r o j e c t   i n s t a n c e   t o   " A c t i v e "   i f   t h e   t e m p l a t e   p r o j e c t   w a s   " O n   H o l d " 
 	 
 	 
 	 #   L I C E N S E 
 	 
 	 U s e   i t ,   c h a n g e   i t ,   e n j o y   i t .   P l e a s e   d o n ' t   b l a t e n t l y   p a s s   o f f   m y   w o r k   a s   y o u r   o w n .   B e   c o o l . 
 	 
 	 
 	 #   I N S T A L L A T I O N 
 	 
 	 - 	 C o p y   t h i s   s c r i p t   t o   ~ / L i b r a r y / S c r i p t s / A p p l i c a t i o n s / O m n i f o c u s   ( y o u   m a y   h a v e   t o   u s e   t h e 
 	 	 G o   >   G o   t o   F o l d e r &   m e n u   i n   y o u r   f i l e   n a v i g a t i o n   a p p l i c a t i o n   o f   c h o i c e   a s   t h e   u s e r   l i b r a r y 
 	 	 f o l d e r   i s   h i d d e n   o n   M a c   O S   X   1 0 . 7 + .   A f t e r   y o u   s e l e c t   t h i s   m e n u   i t e m ,   t y p e   t h e   p a t h   a b o v e   a n d 
 	 	 h i t   e n t e r ) . 
 	 - 	 I f   y o u   p r e f e r ,   y o u   c a n   h a v e   t h i s   s c r i p t   b e   a c t i v a t e d   b y   a   u t i l i t y   l i k e   K e y b o a r d   M a e s t r o   o r   F a s t S c r i p t s 
 	 
 	 
 	 #   V E R S I O N   I N F O R M A T I O N 
 	 	 
 	 	 0 . 2 . 4   ( J a n u a r y   2 2 ,   2 0 1 3 ) :   O t h e r   b u g f i x e s 
 	 	 0 . 2 . 3   ( J a n u a r y   2 2 ,   2 0 1 3 ) :   F i x   f o r   s e t t i n g   d e f a u l t   f o l d e r   t o   a   s u b f o l d e r 
 	 	 0 . 2 . 2   ( J a n u a r y   2 2 ,   2 0 1 3 ) :   A l l o w s   y o u   t o   s e t   b o t h   a   s t a r t   a n d   d u e   d a t e .   F i x e s   a   b u g   w h e r e   d u e /   s t a r t   d e c l a r a t i o n s 
 	 	 i n   p r o j e c t s   w o u l d n ' t   b e   e l i m i n a t e d   w h e n   a   n e w   i n s t a n c e   w a s   c r e a t e d . 
 	 	 0 . 2 . 1   ( J a n u a r y   2 2 ,   2 0 1 3 ) :   D o e s   a   b e t t e r   j o b   o f   c l e a n i n g   u p   n o t e s   a n d   a l l o w s   v a r i a b l e s   o n   a n y   l i n e   o f   p r o j e c t 
 	 	 0 . 2   ( J a n u a r y   2 1 ,   2 0 1 3 ) :   u s i n g   t h e   k e y w o r d   " a s k "   i n   a f t e r   t h e   s t a r t / d u e   d e c l a r a t i o n   i n   t h e   n o t e   o f   a   t a s k /   p r o j e c t   w i l l   h a v e   t h e 
 	 	 s c r i p t   p r o m p t   y o u   t o   e n t e r   a   r e l a t i v e   o r   a b s o l u t e   s t a r t / d u e   d a t e   f o r   t h a t   i t e m .   S i m i l a r l y ,   y o u   c a n   u s e   t h e   k e y w o r d 
 	 	 " p r o j e c t "   t o   s e t   t h e   s t a r t /   d u e   d a t e   r e l a t i v e   t o   t h a t   o f   t h e   p r o j e c t ;   t h e   s c r i p t   w i l l   t a k e   w h a t e v e r   i s 
 	 	 a f t e r   t h e   k e y w o r d   a n d   s u b t r a c t   i t   f r o m   t h e   d u e   d a t e /   a d d   i t   t o   t h e   s t a r t   d a t e   o f   t h e   p r o j e c t ,   a s   t h e 
 	 	 c a s e   m a y   b e .   F i n a l l y ,   u s i n g   t h e   ( b y   d e f a u l t )   " > > > "   o p e r a t o r   i n   t h e   s e c o n d ,   f o l l o w e d   b y   a   s t r i n g   t h a t   E X A C T L Y   m a t c h e s 
 	 	 o n e   o f   t h e   f o l d e r s   i n   y o u r   O F   l i b r a r y   w i l l   s k i p   t h e   f o l d e r   s e l e c t i o n   d i a l o g   a n d   p u t   t h e   n e w   i n s t a n c e 
 	 	 d i r e c t l y   i n   t h e   d e s i g n a t e d   f o l d e r .   P l u s ,   f a n c y   i c o n . 
 	 	 0 . 1 . 1   ( J a n u a r y   1 8 ,   2 0 1 3 ) :   H a n d l e s   p r o j e c t s   i n   a   t e m p l a t e   f o l d e r   w i t h o u t   v a r i a b l e s   m o r e   g r a c e f u l l y   ( t h a n k s ,   S v e n ! ) 
 	 	 0 . 1   ( J a n u a r y   1 8 ,   2 0 1 3 ) :   I n i t i a l   r e l e a s e 
 	 	 
 	 
 	 #   B E I N G   W O R K E D   O N 
 	 
 	 - 	 U s i n g   G r o w l   f o r   n o t i f i c a t i o n s   i f   t h e   u s e r   h a s   i t   i n s t a l l e d   a n d   r u n n i n g . 
 	 
 	 
 	 #   K N O W N   I S S U E S 
 
 	 -   	 D u e /   S t a r t   d a t e   n o t e   s o m e t i m e s   s t a y s   i n   p r o j e c t   a f t e r   t e m p l a t e   i s   p o p u l a t e d   ( s e e m s   t o   b e   w h e n   i t   i s   s e t   t o   a s k ) . 
   
  
 l     ��������  ��  ��        j     �� ��  0 variablesymbol variableSymbol  m        �    $      j    �� �� 0 firstrun firstRun  m    ��
�� boovtrue      j    �� �� .0 specialtemplatefolder specialTemplateFolder  m    ��
�� 
null      j   	 �� �� "0 shownewinstance showNewInstance  m   	 
��
�� boovtrue      j    �� �� ,0 defaultfolderpointer defaultFolderPointer  m       �    > > >       l     ��������  ��  ��      ! " ! l    #���� # O     $ % $ O    & ' & k   
 ( (  ) * ) Z   
 � + ,���� + o   
 ���� 0 firstrun firstRun , k    � - -  . / . r     0 1 0 n    2 3 2 I    �������� .0 checkforothertemplate checkForOtherTemplate��  ��   3  f     1 o      ���� :0 othertemplatescriptprojects otherTemplateScriptProjects /  4 5 4 Z    G 6 7���� 6 >    8 9 8 n     : ; : 1    ��
�� 
leng ; o    ���� :0 othertemplatescriptprojects otherTemplateScriptProjects 9 m    ����   7 k   " C < <  = > = r   " 2 ? @ ? n   " 0 A B A 1   . 0��
�� 
bhit B l  " . C���� C I  " .�� D E
�� .sysodlogaskr        TEXT D m   " # F F � G GN I t   a p p e a r s   t h a t   y o u   h a v e   s o m e   p r o j e c t s   u s i n g   C u r t   C l i f t o n ' s   O m n i F o c u s   t e m p l a t e   s c r i p t   s y n t a x .   W o u l d   y o u   l i k e   t o   a u t o m a t i c a l l y   a d j u s t   t h e s e   t o   u s e   t h i s   s c r i p t ' s   s y n t a x ? E �� H I
�� 
btns H J   $ ( J J  K L K m   $ % M M � N N  N o ,   T h a n k s L  O�� O m   % & P P � Q Q $ Y e s ,   C h a n g e   S y n t a x��   I �� R��
�� 
dflt R m   ) *���� ��  ��  ��   @ o      ���� (0 changeoldtemplates changeOldTemplates >  S�� S Z  3 C T U���� T =  3 6 V W V o   3 4���� (0 changeoldtemplates changeOldTemplates W m   4 5 X X � Y Y $ Y e s ,   C h a n g e   S y n t a x U n  9 ? Z [ Z I   : ?�� \���� 20 adjustoldtemplatesyntax adjustOldTemplateSyntax \  ]�� ] o   : ;���� :0 othertemplatescriptprojects otherTemplateScriptProjects��  ��   [  f   9 :��  ��  ��  ��  ��   5  ^ _ ^ l  H H��������  ��  ��   _  ` a ` Q   H x b c d b r   K b e f e n   K \ g h g 1   X \��
�� 
ttxt h l  K X i���� i I  K X�� j k
�� .sysodlogaskr        TEXT j m   K N l l � m m � W h a t   s y m b o l   w o u l d   y o u   l i k e   t o   u s e   t o   d e s i g n a t e   v a r i a b l e   n a m e s   i n   y o u r   t e m p l a t e s ? k �� n��
�� 
dtxt n m   Q T o o � p p  $��  ��  ��   f o      ����  0 variablesymbol variableSymbol c R      �� q r
�� .ascrerr ****      � **** q o      ���� 0 	errortext 	errorText r �� s��
�� 
errn s o      ���� 0 errornumber errorNumber��   d Z   j x t u���� t =  j o v w v o   j k���� 0 errornumber errorNumber w m   k n������ u L   r t����  ��  ��   a  x y x l  y y��������  ��  ��   y  z { z Q   y � | } ~ | k   | �    � � � r   | � � � � n   | � � � � 1   � ���
�� 
bhit � l  | � ����� � I  | ��� � �
�� .sysodlogaskr        TEXT � m   |  � � � � � � D o   y o u   w a n t   t h e   s c r i p t   t o   a s k   y o u   i f   y o u ' d   l i k e   t o   s e e   t h e   n e w   i n s t a n c e   o f   y o u r   t e m p l a t e s   a f t e r   e a c h   r u n ? � �� � �
�� 
btns � J   � � � �  � � � m   � � � � � � �  N o ,   T h a n k s �  ��� � m   � � � � � � � $ Y e s ,   A s k   E a c h   T i m e��   � �� ���
�� 
dflt � m   � ����� ��  ��  ��   � o      ���� $0 instancequestion instanceQuestion �  ��� � r   � � � � � l  � � ����� � =  � � � � � o   � ����� $0 instancequestion instanceQuestion � m   � � � � � � � $ Y e s ,   A s k   E a c h   T i m e��  ��   � o      ���� "0 shownewinstance showNewInstance��   } R      �� � �
�� .ascrerr ****      � **** � o      ���� 0 	errortext 	errorText � �� ���
�� 
errn � o      ���� 0 errornumber errorNumber��   ~ Z   � � � ����� � =  � � � � � o   � ����� 0 errornumber errorNumber � m   � ������� � L   � �����  ��  ��   {  ��� � r   � � � � � m   � ���
�� boovfals � o      ���� 0 firstrun firstRun��  ��  ��   *  � � � l  � ���������  ��  ��   �  � � � r   � � � � � l  � � ����� � I  � ��� ���
�� .corecnte****       **** � l  � � ����� � 6 � � � � � 2   � ���
�� 
FCff � l  � � ����� � E   � � � � � n  � � � � � 1   � ���
�� 
pnam �  g   � � � m   � � � � � � �  T e m p l a t e��  ��  ��  ��  ��  ��  ��   � o      ���� 0 thecount theCount �  � � � Z   �� � ��� � � l  � ����� � =  � � � � l  � ����� � I  ��� ���
�� .corecnte****       **** � l  � ����� � 6 � � � � 2   � ���
�� 
FCff � F   � � � � l  � � ����� � E   � � � � � n  � � � � � 1   � ���
�� 
pnam �  g   � � � m   � � � � � � �  T e m p l a t e��  ��   � l  �  ����� � =  �  � � � n  � � � � � 1   � ��
� 
FCHi �  g   � � � m   � ��~
�~ boovfals��  ��  ��  ��  ��  ��  ��   � m  �}�}  ��  ��   � k  � � �  � � � r  ! � � � 6 � � � 2  �|
�| 
FCff � l  ��{�z � =  � � � n  � � � 1  �y
�y 
FCHi �  g   � m  �x
�x boovfals�{  �z   � o      �w�w (0 templatefolderlist templateFolderList �  � � � r  "( � � � J  "$�v�v   � o      �u�u 00 templatefoldernamelist templateFolderNameList �  � � � X  )~ ��t � � k  ?y � �  � � � r  ?F � � � m  ?B � � � � �   � o      �s�s 0 nextlistitem nextListItem �  � � � Z Gb � ��r�q � = GT � � � l GP ��p�o � n  GP � � � 1  LP�n
�n 
pcls � n GL � � � 1  HL�m
�m 
ctnr � o  GH�l�l 0 	thefolder 	theFolder�p  �o   � m  PS�k
�k 
FCAr � r  W^ � � � m  WZ � � � � � !�   � o      �j�j 0 nextlistitem nextListItem�r  �q   �  �  � r  cp b  cl o  cf�i�i 0 nextlistitem nextListItem l fk�h�g n  fk 1  gk�f
�f 
pnam o  fg�e�e 0 	thefolder 	theFolder�h  �g   o      �d�d 0 nextlistitem nextListItem  �c r  qy	
	 o  qt�b�b 0 nextlistitem nextListItem
 l     �a�` n        ;  wx o  tw�_�_ 00 templatefoldernamelist templateFolderNameList�a  �`  �c  �t 0 	thefolder 	theFolder � o  ,/�^�^ (0 templatefolderlist templateFolderList �  r  � I ��]
�] .gtqpchltns    @   @ ns   o  ��\�\ 00 templatefoldernamelist templateFolderNameList �[
�[ 
appr m  �� � , C h o o s e   T e m p l a t e   F o l d e r �Z
�Z 
prmp m  �� � � N o   o b v i o u s   t e m p l a t e   f o l d e r s   w e r e   f o u n d .   P l e a s e   s e l e c t   t h e   f o l d e r   i n   w h i c h   y o u   s t o r e   t e m p l a t e s . �Y�X
�Y 
okbt m  �� � , S e t   a s   T e m p l a t e   F o l d e r�X   o      �W�W 00 selectedtemplatefolder selectedTemplateFolder   Z ��!"�V�U! = ��#$# o  ���T�T 00 selectedtemplatefolder selectedTemplateFolder$ m  ���S
�S boovfals" L  ���R�R  �V  �U    %&% r  ��'(' n ��)*) I  ���Q+�P�Q (0 selectionpositions selectionPositions+ ,-, o  ���O�O 00 selectedtemplatefolder selectedTemplateFolder- ./. o  ���N�N 00 templatefoldernamelist templateFolderNameList/ 0�M0 m  ���L
�L boovfals�M  �P  *  f  ��( o      �K�K 00 templatefolderposition templateFolderPosition& 1�J1 r  ��232 n  ��454 4  ���I6
�I 
cobj6 o  ���H�H 00 templatefolderposition templateFolderPosition5 o  ���G�G (0 templatefolderlist templateFolderList3 o      �F�F .0 specialtemplatefolder specialTemplateFolder�J  ��   � r  ��787 m  ���E
�E 
null8 o      �D�D .0 specialtemplatefolder specialTemplateFolder � 9:9 l ���C�B�A�C  �B  �A  : ;<; Z  �Y=>�@?= = ��@A@ o  ���?�? .0 specialtemplatefolder specialTemplateFolderA m  ���>
�> 
null> r  � BCB 6�DED 2  ���=
�= 
FCfxE F  �FGF F  �HIH l �J�<�;J E  �KLK n  ��MNM 1  ���:
�: 
pnamN n ��OPO m  ���9
�9 
FCArP  g  ��L m  � QQ �RR  T e m p l a t e�<  �;  I l S�8�7S > TUT n VWV 1  �6
�6 
FCPsW  g  U m  �5
�5 FCPsFCPD�8  �7  G l X�4�3X > YZY n [\[ 1  �2
�2 
FCPs\  g  Z m  �1
�1 FCPsFCPd�4  �3  C o      �0�0 0 projectlist projectList�@  ? r  #Y]^] 6#U_`_ 2  #(�/
�/ 
FCfx` F  +Taba F  ,Gcdc l -:e�.�-e = -:fgf n .2hih m  .2�,
�, 
FCAri  g  ..g o  39�+�+ .0 specialtemplatefolder specialTemplateFolder�.  �-  d l ;Fj�*�)j > ;Fklk n <@mnm 1  <@�(
�( 
FCPsn  g  <<l m  AE�'
�' FCPsFCPD�*  �)  b l HSo�&�%o > HSpqp n IMrsr 1  IM�$
�$ 
FCPss  g  IIq m  NR�#
�# FCPsFCPd�&  �%  ^ o      �"�" 0 projectlist projectList< tut r  Z`vwv J  Z\�!�!  w o      � �  "0 projectnamelist projectNameListu xyx X  a�z�{z r  w�|}| l w|~��~ n  w|� 1  x|�
� 
pnam� o  wx�� 0 
theproject 
theProject�  �  } l     ���� n      ���  ;  �� o  |�� "0 projectnamelist projectNameList�  �  � 0 
theproject 
theProject{ o  dg�� 0 projectlist projectListy ��� Z  ������� = ����� n  ����� 1  ���
� 
leng� o  ���� "0 projectnamelist projectNameList� m  ����  � k  ���� ��� I �����
� .sysodisAaleR        TEXT� m  ���� ��� p N o   a v a i l a b l e   p r o j e c t s   i n   a   " T e m p l a t e "   f o l d e r   w e r e   f o u n d .�  � ��� L  ����  �  �  �  � ��� l ������  �  �  � ��� r  ����� m  ���� ��� 2 S e l e c t   a   T e m p l a t e   P r o j e c t� o      �
�
 "0 chooselisttitle chooseListTitle� ��� r  ����� m  ���� ��� � W h i c h   o n e   o f   y o u r   t e m p l a t e   p r o j e c t s   w o u l d   y o u   l i k e   t o   m a k e   a   n e w   i n s t a n c e   o f ?� o      �	�	  0 chooselisttext chooseListText� ��� r  ����� m  ���� ��� & S e l e c t   T h i s   P r o j e c t� o      �� 0 chooselistok chooseListOK� ��� r  ����� I �����
� .gtqpchltns    @   @ ns  � o  ���� "0 projectnamelist projectNameList� ���
� 
appr� o  ���� "0 chooselisttitle chooseListTitle� ���
� 
prmp� o  ����  0 chooselisttext chooseListText� ��� 
� 
okbt� o  ������ 0 chooselistok chooseListOK�   � o      ���� "0 selectedproject selectedProject� ��� Z ��������� = ����� o  ������ "0 selectedproject selectedProject� m  ����
�� boovfals� L  ������  ��  ��  � ��� r  ����� n ����� I  ��������� (0 selectionpositions selectionPositions� ��� o  ������ "0 selectedproject selectedProject� ��� o  ������ "0 projectnamelist projectNameList� ���� m  ����
�� boovfals��  ��  �  f  ��� o      ���� "0 projectposition projectPosition� ��� r  ���� n  ���� 4  ����
�� 
cobj� o  ����� "0 projectposition projectPosition� o  ������ 0 projectlist projectList� o      ���� 20 selectedprojecttemplate selectedProjectTemplate� ��� l ��������  ��  ��  � ��� r  ,��� 6(��� 2  ��
�� 
FCff� F  '��� l ������ H  �� E  ��� n ��� 1  ��
�� 
pnam�  g  � m  �� ���  T e m p l a t e��  ��  � l &������ = &��� n "��� 1  "��
�� 
FCHe�  g  � m  #%��
�� boovfals��  ��  � o      ���� 0 
folderlist 
folderList� ��� r  -6��� J  -2�� ���� m  -0�� ���  ( T o p   L e v e l )��  � o      ����  0 foldernamelist folderNameList� ��� X  7������ k  M��� ��� r  MT��� m  MP�� ���  � o      ���� 0 nextlistitem nextListItem� ��� Z Up������� = Ub��� l U^������ n  U^��� 1  Z^��
�� 
pcls� n UZ��� 1  VZ��
�� 
ctnr� o  UV���� 0 	thefolder 	theFolder��  ��  � m  ^a��
�� 
FCAr� r  el   m  eh � !�   o      ���� 0 nextlistitem nextListItem��  ��  �  r  q~ b  qz	 o  qt���� 0 nextlistitem nextListItem	 l ty
����
 n  ty 1  uy��
�� 
pnam o  tu���� 0 	thefolder 	theFolder��  ��   o      ���� 0 nextlistitem nextListItem �� r  � o  ����� 0 nextlistitem nextListItem l     ���� n        ;  �� o  ������  0 foldernamelist folderNameList��  ��  ��  �� 0 	thefolder 	theFolder� o  :=���� 0 
folderlist 
folderList�  l ����������  ��  ��    r  �� m  ����
�� boovfals o      ���� (0 defaultfolderfound defaultFolderFound  r  �� m  ������   o      ����  0 folderposition folderPosition  Z  �� ���� E  ��!"! l ��#����# n  ��$%$ 1  ����
�� 
FCno% o  ������ 20 selectedprojecttemplate selectedProjectTemplate��  ��  " o  ������ ,0 defaultfolderpointer defaultFolderPointer  k  ��&& '(' r  ��)*) m  ��������* o      ���� "0 parawithpointer paraWithPointer( +,+ Y  ��-��./0- Z ��12����1 C  ��343 n  ��565 4  ����7
�� 
cpar7 o  ������ 0 i  6 l ��8����8 n  ��9:9 1  ����
�� 
FCno: o  ������ 20 selectedprojecttemplate selectedProjectTemplate��  ��  4 o  ������ ,0 defaultfolderpointer defaultFolderPointer2 r  ��;<; o  ������ 0 i  < o      ���� "0 parawithpointer paraWithPointer��  ��  �� 0 i  . l ��=����= I ����>��
�� .corecnte****       ****> n ��?@? 2 ����
�� 
cpar@ l ��A����A n  ��BCB 1  ����
�� 
FCnoC o  ������ 20 selectedprojecttemplate selectedProjectTemplate��  ��  ��  ��  ��  / m  ������ 0 m  ��������, DED r  ��FGF n  ��HIH 4  ����J
�� 
cparJ o  ������ "0 parawithpointer paraWithPointerI l ��K����K n  ��LML 1  ����
�� 
FCnoM o  ������ 20 selectedprojecttemplate selectedProjectTemplate��  ��  G o      ���� 0 folderpointer folderPointerE NON r   PQP J   RR STS o   ���� ,0 defaultfolderpointer defaultFolderPointerT U��U b  VWV o  
���� ,0 defaultfolderpointer defaultFolderPointerW m  
XX �YY   ��  Q n     Z[Z 1  ��
�� 
txdl[  f  O \]\ r  "^_^ n  `a` 2  ��
�� 
citma o  ���� 0 folderpointer folderPointer_ o      ���� 0 folderpointer folderPointer] bcb r  #,ded m  #&ff �gg  e n     hih 1  '+��
�� 
txdli  f  &'c jkj r  -8lml c  -4non o  -0���� 0 folderpointer folderPointero m  03��
�� 
TEXTm o      ���� &0 folderpointername folderPointerNamek pqp Y  9ir��st��r Z Hduv����u E HXwxw o  HK���� &0 folderpointername folderPointerNamex n  KWyzy 1  SW��
�� 
pnamz n  KS{|{ 4  NS��}
�� 
cobj} o  QR���� 0 i  | o  KN���� 0 
folderlist 
folderListv r  [`~~ o  [\���� 0 i   o      ����  0 folderposition folderPosition��  ��  �� 0 i  s m  <=���� t l =C������ n  =C��� 1  @B��
�� 
leng� o  =@���� 0 
folderlist 
folderList��  ��  ��  q ��� Z  j����~�}� > jo��� o  jm�|�|  0 folderposition folderPosition� m  mn�{�{  � k  r��� ��� r  rw��� m  rs�z
�z boovtrue� o      �y�y (0 defaultfolderfound defaultFolderFound� ��x� r  x���� n  x���� 4  {��w�
�w 
cobj� o  ~��v�v  0 folderposition folderPosition� o  x{�u�u 0 
folderlist 
folderList� o      �t�t 00 selectedfoldertemplate selectedFolderTemplate�x  �~  �}  �  ��  ��   ��� l ���s�r�q�s  �r  �q  � ��� r  ����� n ����� I  ���p��o�p $0 findthevariables findTheVariables� ��n� o  ���m�m 20 selectedprojecttemplate selectedProjectTemplate�n  �o  �  f  ��� o      �l�l 0 thevariables theVariables� ��� l ���k�j�i�k  �j  �i  � ��� r  ����� m  ���� ���  � o      �h�h 0 justduplicate justDuplicate� ��� Z  �����g�f� = ����� l ����e�d� n  ����� 1  ���c
�c 
leng� o  ���b�b 0 thevariables theVariables�e  �d  � m  ���a�a  � k  ���� ��� r  ����� n  ����� 1  ���`
�` 
bhit� l ����_�^� I ���]��
�] .sysodisAaleR        TEXT� b  ����� b  ����� b  ����� b  ����� b  ����� m  ���� ���� N o   v a r i a b l e s   w e r e   f o u n d   i n   t h e   s e l e c t e d   p r o j e c t .   D o   y o u   w a n t   t o   s i m p l y   c o p y   t h i s   p r o j e c t   t o   t h e   s e l e c t e d   f o l d e r ?   ( M a k e   s u r e   t h a t   a n y   v a r i a b l e s   a r e   i n   t h e   f i n a l   p a r a g r a p h   i n   t h e   p r o j e c t ' s   n o t e   a n d   a r e   i n   t h e   f o r m a t :  � 1  ���\
�\ 
quot� o  ���[�[  0 variablesymbol variableSymbol� m  ���� ���  v a r i a b l e N a m e� 1  ���Z
�Z 
quot� m  ���� ���  ) .� �Y��
�Y 
btns� J  ���� ��� m  ���� ���  N o ,   N e v e r m i n d� ��X� m  ���� ���  Y e s ,   D u p l i c a t e�X  � �W��V
�W 
dflt� m  ���U�U �V  �_  �^  � o      �T�T 0 justduplicate justDuplicate� ��S� Z �����R�Q� > ����� o  ���P�P 0 justduplicate justDuplicate� m  ���� ���  Y e s ,   D u p l i c a t e� L  ���O�O  �R  �Q  �S  �g  �f  � ��� l ���N�M�L�N  �M  �L  � ��� Z  �y���K�J� H  ���� o  ���I�I (0 defaultfolderfound defaultFolderFound� k  �u�� ��� r  � ��� m  ���� ��� Z S e l e c t   a   F o l d e r   F o r   T h e   N e w   T e m p l a t e   I n s t a n c e� o      �H�H "0 chooselisttitle chooseListTitle� ��� r  ��� m  �� ��� � I n   w h i c h   f o l d e r   w o u l d   y o u   l i k e   t o   c r e a t e   a   n e w   i n s t a n c e   o f   t h i s   t e m p l a t e ?� o      �G�G  0 chooselisttext chooseListText� ��� r  	��� m  	�� ��� , M a k e   T e m p l a t e   I n s t a n c e� o      �F�F 0 chooselistok chooseListOK� ��� r  0��� I ,�E��
�E .gtqpchltns    @   @ ns  � o  �D�D  0 foldernamelist folderNameList� �C��
�C 
appr� o  �B�B "0 chooselisttitle chooseListTitle� �A��
�A 
prmp� o   �@�@  0 chooselisttext chooseListText� �?��>
�? 
okbt� o  #&�=�= 0 chooselistok chooseListOK�>  � o      �<�<  0 selectedfolder selectedFolder� ��;� Z  1u   = 16 o  14�:�:  0 selectedfolder selectedFolder m  45�9
�9 boovfals L  9;�8�8    = >G	 o  >A�7�7  0 selectedfolder selectedFolder	 J  AF

 �6 m  AD �  ( T o p   L e v e l )�6   �5 r  JQ m  JM �  T o p   L e v e l o      �4�4 00 selectedfoldertemplate selectedFolderTemplate�5   k  Tu  r  Tf l Tb�3�2 \  Tb l T`�1�0 n T` I  U`�/�.�/ (0 selectionpositions selectionPositions   o  UX�-�-  0 selectedfolder selectedFolder  !"! o  X[�,�,  0 foldernamelist folderNameList" #�+# m  [\�*
�* boovfals�+  �.    f  TU�1  �0   m  `a�)�) �3  �2   o      �(�(  0 folderposition folderPosition $�'$ r  gu%&% n  gq'(' 4  jq�&)
�& 
cobj) o  mp�%�%  0 folderposition folderPosition( o  gj�$�$ 0 
folderlist 
folderList& o      �#�# 00 selectedfoldertemplate selectedFolderTemplate�'  �;  �K  �J  � *+* l zz�"�!� �"  �!  �   + ,-, Z  zB./��. = z�010 o  z}�� 0 justduplicate justDuplicate1 m  }�22 �33  Y e s ,   D u p l i c a t e/ k  �>44 565 Z  ��78�97 = ��:;: o  ���� 00 selectedfoldertemplate selectedFolderTemplate; m  ��<< �==  T o p   L e v e l8 r  ��>?> l ��@��@ I ���AB
� .coreclon****      � ****A o  ���� 20 selectedprojecttemplate selectedProjectTemplateB �C�
� 
inshC l ��D��D n  ��EFE  ;  ��F n  ��GHG 2 ���
� 
FCprH  g  ���  �  �  �  �  ? o      �� (0 newprojectinstance newProjectInstance�  9 r  ��IJI l ��K��K I ���LM
� .coreclon****      � ****L o  ���� 20 selectedprojecttemplate selectedProjectTemplateM �N�
� 
inshN l ��O�
�	O n  ��PQP  ;  ��Q n  ��RSR 2 ���
� 
FCprS o  ���� 00 selectedfoldertemplate selectedFolderTemplate�
  �	  �  �  �  J o      �� (0 newprojectinstance newProjectInstance6 TUT Z ��VW��V = ��XYX n  ��Z[Z 1  ���
� 
FCPs[ o  ���� (0 newprojectinstance newProjectInstanceY m  ���
� FCPsFCPhW r  ��\]\ m  ��� 
�  FCPsFCPa] n      ^_^ 1  ����
�� 
FCPs_ o  ������ (0 newprojectinstance newProjectInstance�  �  U `a` Z  �3bc����b o  ������ "0 shownewinstance showNewInstancec k  �/dd efe r  ��ghg n  ��iji 1  ����
�� 
bhitj l ��k����k I ����lm
�� .sysodlogaskr        TEXTl m  ��nn �oo r W o u l d   y o u   l i k e   t o   v i e w   t h e   n e w   i n s t a n c e   o f   y o u r   t e m p l a t e ?m ��pq
�� 
btnsp J  ��rr sts m  ��uu �vv  N o ,   T h a n k st w��w m  ��xx �yy " V i e w   N e w   I n s t a n c e��  q ��z��
�� 
dfltz m  ������ ��  ��  ��  h o      ����  0 focusonproject focusOnProjectf {��{ Z  �/|}����| = �~~ o  ������  0 focusonproject focusOnProject m  ��� ��� " V i e w   N e w   I n s t a n c e} k  +�� ��� r  ��� J  ����  � o      ���� 0 	focuslist 	focusList� ��� r  ��� o  ���� (0 newprojectinstance newProjectInstance� n      ���  ;  � o  ���� 0 	focuslist 	focusList� ���� I +�����
�� .corecrel****      � null��  � ����
�� 
kocl� m  ��
�� 
FCdw� �����
�� 
prdt� K  '�� �����
�� 
FCFs� o  "%���� 0 	focuslist 	focusList��  ��  ��  ��  ��  ��  ��  ��  a ��� r  4;��� m  47�� ���  � o      ���� 0 justduplicate justDuplicate� ���� L  <>����  ��  �  �  - ��� l CC��������  ��  ��  � ��� r  CO��� n CK��� I  DK������� *0 findthereplacements findTheReplacements� ���� o  DG���� 0 thevariables theVariables��  ��  �  f  CD� o      ���� "0 thereplacements theReplacements� ��� Z P^������� = PU��� l PS������ 1  PS��
�� 
rslt��  ��  � m  ST��
�� boovfals� L  XZ����  ��  ��  � ��� l __��������  ��  ��  � ��� Z  _������� = _f��� o  _b���� 00 selectedfoldertemplate selectedFolderTemplate� m  be�� ���  T o p   L e v e l� r  i}��� l iy������ I iy����
�� .coreclon****      � ****� o  il���� 20 selectedprojecttemplate selectedProjectTemplate� �����
�� 
insh� l ou������ n  ou���  ;  tu� n  ot��� 2 pt��
�� 
FCpr�  g  op��  ��  ��  ��  ��  � o      ���� (0 newprojectinstance newProjectInstance��  � r  ����� l �������� I ������
�� .coreclon****      � ****� o  ������ 20 selectedprojecttemplate selectedProjectTemplate� �����
�� 
insh� l �������� n  �����  ;  ��� n  ����� 2 ����
�� 
FCpr� o  ������ 00 selectedfoldertemplate selectedFolderTemplate��  ��  ��  ��  ��  � o      ���� (0 newprojectinstance newProjectInstance� ��� Z ��������� = ����� n  ����� 1  ����
�� 
FCPs� o  ������ (0 newprojectinstance newProjectInstance� m  ����
�� FCPsFCPh� r  ����� m  ����
�� FCPsFCPa� n      ��� 1  ����
�� 
FCPs� o  ������ (0 newprojectinstance newProjectInstance��  ��  � ��� Z  ��������� o  ������ (0 defaultfolderfound defaultFolderFound� k  ���� ��� s  ����� l �������� n  ����� 1  ����
�� 
FCno� o  ������ (0 newprojectinstance newProjectInstance��  ��  � o      ���� 0 tempnote tempNote� ��� Y  �������� k  ���� ��� Z ��������� C  ����� n  ����� 4  �����
�� 
cpar� o  ������ 0 i  � o  ������ 0 tempnote tempNote� o  ������ ,0 defaultfolderpointer defaultFolderPointer� r  ����� o  ������ 0 i  � o      ���� "0 parawithpointer paraWithPointer��  ��  � ����  S  ����  �� 0 i  � l �������� I �������
�� .corecnte****       ****� n ����� 2 ����
�� 
cpar� l �������� n  ����� 1  ����
�� 
FCno� o  ������ 20 selectedprojecttemplate selectedProjectTemplate��  ��  ��  ��  ��  � m  ������ � m  ��������� � � r   J   �� o  ��
�� 
ret ��   n      1  ��
�� 
txdl  f     Z  �	
	 =  o  ���� "0 parawithpointer paraWithPointer m  ���� 
 r  - c  ) n  % 7 %��
�� 
cpar m  !����  m  "$������ o  ���� 0 tempnote tempNote m  %(��
�� 
TEXT l     ���� o      ���� 0 newnote newNote��  ��    = 0C o  03���� "0 parawithpointer paraWithPointer l 3B��~ I 3B�}�|
�} .corecnte****       **** n  3> 2 :>�{
�{ 
cpar n  3: !  1  6:�z
�z 
FCno! o  36�y�y 20 selectedprojecttemplate selectedProjectTemplate�|  �  �~   "�x" r  F_#$# c  F[%&% n  FW'(' 7 IW�w)*
�w 
cpar) m  OQ�v�v * m  RV�u�u��( o  FI�t�t 0 tempnote tempNote& m  WZ�s
�s 
TEXT$ l     +�r�q+ o      �p�p 0 newnote newNote�r  �q  �x   r  b�,-, c  b�./. l b�0�o�n0 b  b�121 l bu3�m�l3 n  bu454 7 eu�k67
�k 
cpar6 m  km�j�j 7 l nt8�i�h8 \  nt9:9 o  or�g�g "0 parawithpointer paraWithPointer: m  rs�f�f �i  �h  5 o  be�e�e 0 tempnote tempNote�m  �l  2 l u�;�d�c; n  u�<=< 7 x��b>?
�b 
cpar> l ~�@�a�`@ [  ~�ABA o  ��_�_ "0 parawithpointer paraWithPointerB m  ���^�^ �a  �`  ? m  ���]�]��= o  ux�\�\ 0 tempnote tempNote�d  �c  �o  �n  / m  ���[
�[ 
TEXT- l     C�Z�YC o      �X�X 0 newnote newNote�Z  �Y   DED r  ��FGF m  ��HH �II  G n     JKJ 1  ���W
�W 
txdlK  f  ��E L�VL r  ��MNM o  ���U�U 0 newnote newNoteN l     O�T�SO n      PQP 1  ���R
�R 
FCnoQ o  ���Q�Q (0 newprojectinstance newProjectInstance�T  �S  �V  ��  ��  � RSR l ���P�O�N�P  �O  �N  S TUT n ��VWV I  ���MX�L�M $0 populatetemplate populateTemplateX YZY o  ���K�K (0 newprojectinstance newProjectInstanceZ [\[ o  ���J�J 0 thevariables theVariables\ ]�I] o  ���H�H "0 thereplacements theReplacements�I  �L  W  f  ��U ^_^ l ���G�F�E�G  �F  �E  _ `�D` Z  �ab�C�Ba o  ���A�A "0 shownewinstance showNewInstanceb k  �cc ded r  ��fgf n  ��hih 1  ���@
�@ 
bhiti l ��j�?�>j I ���=kl
�= .sysodlogaskr        TEXTk m  ��mm �nn r W o u l d   y o u   l i k e   t o   v i e w   t h e   n e w   i n s t a n c e   o f   y o u r   t e m p l a t e ?l �<op
�< 
btnso J  ��qq rsr m  ��tt �uu  N o ,   T h a n k ss v�;v m  ��ww �xx " V i e w   N e w   I n s t a n c e�;  p �:y�9
�: 
dflty m  ���8�8 �9  �?  �>  g o      �7�7  0 focusonproject focusOnProjecte z�6z Z  �{|�5�4{ = ��}~} o  ���3�3  0 focusonproject focusOnProject~ m  �� ��� " V i e w   N e w   I n s t a n c e| k  ��� ��� r  ����� J  ���2�2  � o      �1�1 0 	focuslist 	focusList� ��� r  ����� o  ���0�0 (0 newprojectinstance newProjectInstance� n      ���  ;  ��� o  ���/�/ 0 	focuslist 	focusList� ��.� I ��-�,�
�- .corecrel****      � null�,  � �+��
�+ 
kocl� m  ���*
�* 
FCdw� �)��(
�) 
prdt� K   �� �'��&
�' 
FCFs� o  �%�% 0 	focuslist 	focusList�&  �(  �.  �5  �4  �6  �C  �B  �D   ' 1    �$
�$ 
FCDo % m     ���                                                                                  OFOC  alis    X  Macintosh HD               �0ڲH+     OOmniFocus.app                                                   ��>2        ����  	                Applications    �1�      �>Lr       O  (Macintosh HD:Applications: OmniFocus.app    O m n i F o c u s . a p p    M a c i n t o s h   H D  Applications/OmniFocus.app  / ��  ��  ��   " ��� l     �#�"�!�#  �"  �!  � ��� l     � ���   �  �  � ��� i    ��� I      ���� (0 selectionpositions selectionPositions� ��� o      �� 0 
selectlist 
selectList� ��� o      �� 0 originallist originalList� ��� o      �� (0 multipleselections multipleSelections�  �  � k     ��� ��� Z     ������ o     �� (0 multipleselections multipleSelections� k    q�� ��� r    ��� m    ��  � o      �� 0 choicesfound choicesFound� ��� r    ��� J    
��  � o      �� ,0 positionofselections positionOfSelections� ��� r    ��� m    �� � o      �� 0 j  � ��� W    q��� k   % l�� ��� r   % (��� m   % &�� � o      �� 0 k  � ��� r   ) ,��� m   ) *�
� boovfals� o      �� 0 achoicefound aChoiceFound� ��� W   - f��� k   = a�� ��� Z   = [���
�	� E   = F��� l  = A���� n   = A��� 4   > A��
� 
cobj� o   ? @�� 0 k  � o   = >�� 0 
selectlist 
selectList�  �  � l  A E���� n   A E��� 4   B E��
� 
cobj� o   C D� �  0 j  � o   A B���� 0 originallist originalList�  �  � k   I W�� ��� r   I M��� o   I J���� 0 j  � n      ���  ;   K L� o   J K���� ,0 positionofselections positionOfSelections� ��� r   N Q��� m   N O��
�� boovtrue� o      ���� 0 achoicefound aChoiceFound� ���� r   R W��� l  R U������ [   R U��� o   R S���� 0 choicesfound choicesFound� m   S T���� ��  ��  � o      ���� 0 choicesfound choicesFound��  �
  �	  � ���� r   \ a��� [   \ _��� o   \ ]���� 0 k  � m   ] ^���� � o      ���� 0 k  ��  � G   1 <��� l  1 6������ ?   1 6��� o   1 2���� 0 k  � l  2 5������ n   2 5��� 1   3 5��
�� 
leng� o   2 3���� 0 
selectlist 
selectList��  ��  ��  ��  � o   9 :���� 0 achoicefound aChoiceFound� ���� r   g l��� [   g j��� o   g h���� 0 j  � m   h i���� � o      ���� 0 j  ��  � G    $��� l   ������ ?    ��� o    ���� 0 j  � l   ������ n    ��� 1    ��
�� 
leng� o    ���� 0 originallist originalList��  ��  ��  ��  � l   "������ =    "   o    ���� 0 choicesfound choicesFound l   !���� n    ! 1    !��
�� 
leng o    ���� 0 
selectlist 
selectList��  ��  ��  ��  �  �  � k   t �  r   t w	 m   t u���� 	 o      ���� 0 j   

 r   x { m   x y��
�� 
null o      ���� ,0 positionofselections positionOfSelections �� W   | � k   � �  r   � � m   � �����  o      ���� 0 k    W   � � k   � �  Z   � ����� E   � �  l  � �!����! n   � �"#" 4   � ���$
�� 
cobj$ o   � ����� 0 k  # o   � ����� 0 
selectlist 
selectList��  ��    l  � �%����% n   � �&'& 4   � ���(
�� 
cobj( o   � ����� 0 j  ' o   � ����� 0 originallist originalList��  ��   r   � �)*) o   � ����� 0 j  * o      ���� ,0 positionofselections positionOfSelections��  ��   +��+ r   � �,-, [   � �./. o   � ����� 0 k  / m   � ����� - o      ���� 0 k  ��   l  � �0����0 G   � �121 l  � �3����3 ?   � �454 o   � ����� 0 k  5 l  � �6����6 n   � �787 1   � ���
�� 
leng8 o   � ����� 0 
selectlist 
selectList��  ��  ��  ��  2 l  � �9����9 >  � �:;: o   � ����� ,0 positionofselections positionOfSelections; m   � ���
�� 
null��  ��  ��  ��   <��< r   � �=>= [   � �?@? o   � ����� 0 j  @ m   � ����� > o      ���� 0 j  ��   l  � �A����A G   � �BCB ?   � �DED o   � ����� 0 j  E l  � �F����F n   � �GHG 1   � ���
�� 
lengH o   � ����� 0 originallist originalList��  ��  C l  � �I����I >  � �JKJ o   � ����� ,0 positionofselections positionOfSelectionsK m   � ���
�� 
null��  ��  ��  ��  ��  � L��L L   � �MM o   � ����� ,0 positionofselections positionOfSelections��  � NON l     ��������  ��  ��  O PQP l     ��������  ��  ��  Q RSR i    TUT I      ��V���� $0 populatetemplate populateTemplateV WXW o      ���� 0 
theproject 
theProjectX YZY o      ���� $0 cleanedvariables cleanedVariablesZ [��[ o      ���� "0 thereplacements theReplacements��  ��  U k    �\\ ]^] r     _`_ J     ����  ` o      ���� .0 delimcleanedvariables delimCleanedVariables^ aba Y    $c��de��c r    fgf l   h����h b    iji o    ����  0 variablesymbol variableSymbolj l   k����k n    lml 4    ��n
�� 
cobjn o    ���� 0 i  m o    ���� $0 cleanedvariables cleanedVariables��  ��  ��  ��  g l     o����o n      pqp  ;    q o    ���� .0 delimcleanedvariables delimCleanedVariables��  ��  �� 0 i  d m    	���� e l  	 r����r n   	 sts 1   
 ��
�� 
lengt o   	 
���� $0 cleanedvariables cleanedVariables��  ��  ��  b u�u O   %�vwv O   )�xyx O   /�z{z k   3�|| }~} r   3 A� n  3 =��� I   4 =�~��}�~ $0 replacevariables replaceVariables� ��� n  4 7��� 1   5 7�|
�| 
pnam�  g   4 5� ��� o   7 8�{�{ .0 delimcleanedvariables delimCleanedVariables� ��z� o   8 9�y�y "0 thereplacements theReplacements�z  �}  �  f   3 4� n     ��� 1   > @�x
�x 
pnam�  g   = >~ ��� r   B G��� n  B E��� 1   C E�w
�w 
FCno�  g   B C� o      �v�v 0 thefullnote theFullNote� ��� r   H P��� n  H N��� I   I N�u��t�u (0 eliminatevariables eliminateVariables� ��s� o   I J�r�r 0 thefullnote theFullNote�s  �t  �  f   H I� o      �q�q 0 
thenewnote 
theNewNote� ��� r   Q ]��� n  Q Y��� I   R Y�p��o�p $0 replacevariables replaceVariables� ��� o   R S�n�n 0 
thenewnote 
theNewNote� ��� o   S T�m�m .0 delimcleanedvariables delimCleanedVariables� ��l� o   T U�k�k "0 thereplacements theReplacements�l  �o  �  f   Q R� n     ��� 1   Z \�j
�j 
FCno�  g   Y Z� ��� r   ^ f��� n  ^ d��� I   _ d�i��h�i 80 checkingfordateinformation checkingForDateInformation� ��g�  g   _ `�g  �h  �  f   ^ _� o      �f�f (0 possibledatechange possibleDateChange� ��� Z   g ����e�d� >  g j��� o   g h�c�c (0 possibledatechange possibleDateChange� m   h i�b
�b 
msng� k   m ��� ��� Z   m ����a�� =  m s��� n   m q��� 4   n q�`�
�` 
cobj� m   o p�_�_ � o   m n�^�^ (0 possibledatechange possibleDateChange� m   q r�� ��� 
 S t a r t� r   v ~��� n   v z��� 4   w z�]�
�] 
cobj� m   x y�\�\ � o   v w�[�[ (0 possibledatechange possibleDateChange� n     ��� 1   { }�Z
�Z 
FCDs�  g   z {�a  � r   � ���� n   � ���� 4   � ��Y�
�Y 
cobj� m   � ��X�X � o   � ��W�W (0 possibledatechange possibleDateChange� n     ��� 1   � ��V
�V 
FCDd�  g   � �� ��U� r   � ���� n   � ���� 4   � ��T�
�T 
cobj� m   � ��S�S � o   � ��R�R (0 possibledatechange possibleDateChange� n     ��� 1   � ��Q
�Q 
FCno�  g   � ��U  �e  �d  � ��� l  � ��P���P  � . ( Do it again to set second of start/ due   � ��� P   D o   i t   a g a i n   t o   s e t   s e c o n d   o f   s t a r t /   d u e� ��� r   � ���� n  � ���� I   � ��O��N�O 80 checkingfordateinformation checkingForDateInformation� ��M�  g   � ��M  �N  �  f   � �� o      �L�L (0 possibledatechange possibleDateChange� ��� Z   � ����K�J� >  � ���� o   � ��I�I (0 possibledatechange possibleDateChange� m   � ��H
�H 
msng� k   � ��� ��� Z   � ����G�� =  � ���� n   � ���� 4   � ��F�
�F 
cobj� m   � ��E�E � o   � ��D�D (0 possibledatechange possibleDateChange� m   � ��� ��� 
 S t a r t� r   � ���� n   � ���� 4   � ��C�
�C 
cobj� m   � ��B�B � o   � ��A�A (0 possibledatechange possibleDateChange� n     � � 1   � ��@
�@ 
FCDs   g   � ��G  � r   � � n   � � 4   � ��?
�? 
cobj m   � ��>�>  o   � ��=�= (0 possibledatechange possibleDateChange n      1   � ��<
�< 
FCDd  g   � �� �; r   � �	
	 n   � � 4   � ��:
�: 
cobj m   � ��9�9  o   � ��8�8 (0 possibledatechange possibleDateChange
 n      1   � ��7
�7 
FCno  g   � ��;  �K  �J  �  r   � � n  � � I   � ��6�5�6 &0 cleanexcessbreaks cleanExcessBreaks �4 n  � � 1   � ��3
�3 
FCno  g   � ��4  �5    f   � � n      1   � ��2
�2 
FCno  g   � � �1 Y   ���0�/ O   �� !  k   ��"" #$# r   �%&% n  � �'(' I   � ��.)�-�. $0 replacevariables replaceVariables) *+* n  � �,-, 1   � ��,
�, 
pnam-  g   � �+ ./. o   � ��+�+ .0 delimcleanedvariables delimCleanedVariables/ 0�*0 o   � ��)�) "0 thereplacements theReplacements�*  �-  (  f   � �& n     121 1   ��(
�( 
pnam2  g   � �$ 343 r  565 n 787 I  �'9�&�' $0 replacevariables replaceVariables9 :;: n <=< 1  �%
�% 
FCno=  g  ; >?> o  �$�$ .0 delimcleanedvariables delimCleanedVariables? @�#@ o  	�"�" "0 thereplacements theReplacements�#  �&  8  f  6 n     ABA 1  �!
�! 
FCnoB  g  4 CDC Z  2EF� �E > GHG n IJI m  �
� 
FCctJ  g  H m  �
� 
msngF r  .KLK n (MNM I  (�O�� &0 workingthecontext workingTheContextO PQP n "RSR m  "�
� 
FCctS  g  Q TUT o  "#�� .0 delimcleanedvariables delimCleanedVariablesU V�V o  #$�� "0 thereplacements theReplacements�  �  N  f  L n     WXW m  )-�
� 
FCctX  g  ()�   �  D YZY r  3;[\[ n 39]^] I  49�_�� 80 checkingfordateinformation checkingForDateInformation_ `�`  g  45�  �  ^  f  34\ o      �� (0 possibledatechange possibleDateChangeZ aba Z  <mcd��c > <?efe o  <=�� (0 possibledatechange possibleDateChangef m  =>�
� 
msngd k  Bigg hih Z  B`jk�lj = BJmnm n  BFopo 4  CF�q
� 
cobjq m  DE�� p o  BC�
�
 (0 possibledatechange possibleDateChangen m  FIrr �ss 
 S t a r tk r  MUtut n  MQvwv 4  NQ�	x
�	 
cobjx m  OP�� w o  MN�� (0 possibledatechange possibleDateChangeu n     yzy 1  RT�
� 
FCDsz  g  QR�  l r  X`{|{ n  X\}~} 4  Y\�
� 
cobj m  Z[�� ~ o  XY�� (0 possibledatechange possibleDateChange| n     ��� 1  ]_�
� 
FCDd�  g  \]i ��� r  ai��� n  ae��� 4  be� �
�  
cobj� m  cd���� � o  ab���� (0 possibledatechange possibleDateChange� n     ��� 1  fh��
�� 
FCno�  g  ef�  �  �  b ��� l nn������  � . ( Do it again to set second of start/ due   � ��� P   D o   i t   a g a i n   t o   s e t   s e c o n d   o f   s t a r t /   d u e� ��� r  nv��� n nt��� I  ot������� 80 checkingfordateinformation checkingForDateInformation� ����  g  op��  ��  �  f  no� o      ���� (0 possibledatechange possibleDateChange� ��� Z  w�������� > wz��� o  wx���� (0 possibledatechange possibleDateChange� m  xy��
�� 
msng� k  }��� ��� Z  }������� = }���� n  }���� 4  ~����
�� 
cobj� m  ����� � o  }~���� (0 possibledatechange possibleDateChange� m  ���� ��� 
 S t a r t� r  ����� n  ����� 4  �����
�� 
cobj� m  ������ � o  ������ (0 possibledatechange possibleDateChange� n     ��� 1  ����
�� 
FCDs�  g  ����  � r  ����� n  ����� 4  �����
�� 
cobj� m  ������ � o  ������ (0 possibledatechange possibleDateChange� n     ��� 1  ����
�� 
FCDd�  g  ��� ���� r  ����� n  ����� 4  �����
�� 
cobj� m  ������ � o  ������ (0 possibledatechange possibleDateChange� n     ��� 1  ����
�� 
FCno�  g  ����  ��  ��  � ���� r  ����� n ����� I  ��������� &0 cleanexcessbreaks cleanExcessBreaks� ���� n ����� 1  ����
�� 
FCno�  g  ����  ��  �  f  ��� n     ��� 1  ����
�� 
FCno�  g  ����  ! 4   � ����
�� 
FCft� o   � ����� 0 i  �0 0 i   m   � �����  l  � ������� I  � ������
�� .corecnte****       ****� n  � ���� 2  � ���
�� 
FCft�  g   � ���  ��  ��  �/  �1  { o   / 0���� 0 
theproject 
theProjecty 1   ) ,��
�� 
FCDow m   % &���                                                                                  OFOC  alis    X  Macintosh HD               �0ڲH+     OOmniFocus.app                                                   ��>2        ����  	                Applications    �1�      �>Lr       O  (Macintosh HD:Applications: OmniFocus.app    O m n i F o c u s . a p p    M a c i n t o s h   H D  Applications/OmniFocus.app  / ��  �  S ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i    ��� I      ������� $0 replacevariables replaceVariables� ��� o      ���� 0 thetext theText� ��� o      ���� 0 thevariables theVariables� ���� o      ���� "0 thereplacements theReplacements��  ��  � k     9�� ��� Y     6�������� k    1�� ��� r    ��� l   ������ n    ��� 4    ���
�� 
cobj� o    ���� 0 i  � o    ���� 0 thevariables theVariables��  ��  � n     ��� 1    ��
�� 
txdl�  f    � ��� r    ��� n    ��� 2    ��
�� 
citm� o    ���� 0 thetext theText� o      ���� 0 thetext theText� ��� r    $��� l    ������ n     ��� 4     ���
�� 
cobj� o    ���� 0 i  � o    ���� "0 thereplacements theReplacements��  ��  � n     ��� 1   ! #��
�� 
txdl�  f     !�    r   % * c   % ( o   % &���� 0 thetext theText m   & '��
�� 
TEXT o      ���� 0 thetext theText �� r   + 1 J   + -����   n     	
	 1   . 0��
�� 
txdl
  f   - .��  �� 0 i  � m    ���� � l   ���� n     1    ��
�� 
leng o    ���� 0 thevariables theVariables��  ��  ��  � �� L   7 9 o   7 8���� 0 thetext theText��  �  l     ��������  ��  ��    l     ��������  ��  ��    i     I      ������ (0 eliminatevariables eliminateVariables �� o      ���� 0 thenote theNote��  ��   Z     ��� =    	 l    ���� I    �� ��
�� .corecnte****       ****  n     !"! 2   ��
�� 
cpar" o     ���� 0 thenote theNote��  ��  ��   m    ����  L    ## m    $$ �%%  ��   k    �&& '(' Y    <)��*+,) Z   ! 7-.����- C   ! +/0/ n   ! %121 4   " %��3
�� 
cpar3 o   # $���� 0 i  2 o   ! "���� 0 thenote theNote0 o   % *����  0 variablesymbol variableSymbol. k   . 344 565 r   . 1787 o   . /���� 0 i  8 o      ���� $0 variableposition variablePosition6 9��9  S   2 3��  ��  ��  �� 0 i  * l   :����: I   ��;��
�� .corecnte****       ****; n    <=< 2   ��
�� 
cpar= o    ���� 0 thenote theNote��  ��  ��  + m    ���� , m    ������( >?> r   = D@A@ J   = @BB C��C o   = >��
�� 
ret ��  A n     DED 1   A C��
�� 
txdlE  f   @ A? FGF Z   E �HIJKH =  E NLML o   E F���� $0 variableposition variablePositionM l  F MN���N I  F M�~O�}
�~ .corecnte****       ****O l  F IP�|�{P n   F IQRQ 2  G I�z
�z 
cparR o   F G�y�y 0 thenote theNote�|  �{  �}  ��  �  I r   Q `STS c   Q ^UVU l  Q \W�x�wW n   Q \XYX l  R \Z�v�uZ 7  R \�t[\
�t 
cpar[ m   V X�s�s \ m   Y [�r�r���v  �u  Y o   Q R�q�q 0 thenote theNote�x  �w  V m   \ ]�p
�p 
ctxtT o      �o�o 0 
returnnote 
returnNoteJ ]^] =  c f_`_ o   c d�n�n $0 variableposition variablePosition` m   d e�m�m ^ a�la r   i xbcb c   i vded l  i tf�k�jf l  i tg�i�hg n   i thih 7  j t�gjk
�g 
cparj m   n p�f�f k m   q s�e�e��i o   i j�d�d 0 thenote theNote�i  �h  �k  �j  e m   t u�c
�c 
ctxtc o      �b�b 0 
returnnote 
returnNote�l  K r   { �lml c   { �non l  { �p�a�`p b   { �qrq l  { �s�_�^s n   { �tut 7  | ��]vw
�] 
cparv m   � ��\�\ w l  � �x�[�Zx \   � �yzy o   � ��Y�Y $0 variableposition variablePositionz m   � ��X�X �[  �Z  u o   { |�W�W 0 thenote theNote�_  �^  r l  � �{�V�U{ n   � �|}| 7  � ��T~
�T 
cpar~ l  � ���S�R� [   � ���� o   � ��Q�Q $0 variableposition variablePosition� m   � ��P�P �S  �R   m   � ��O�O��} o   � ��N�N 0 thenote theNote�V  �U  �a  �`  o m   � ��M
�M 
ctxtm o      �L�L 0 
returnnote 
returnNoteG ��� r   � ���� m   � ��� ���  � n     ��� 1   � ��K
�K 
txdl�  f   � �� ��J� L   � ��� o   � ��I�I 0 
returnnote 
returnNote�J   ��� l     �H�G�F�H  �G  �F  � ��� l     �E�D�C�E  �D  �C  � ��� i    "��� I      �B��A�B &0 workingthecontext workingTheContext� ��� o      �@�@ 0 
thecontext 
theContext� ��� o      �?�? 0 thevariables theVariables� ��>� o      �=�= "0 thereplacements theReplacements�>  �A  � O     ���� Z    ����<�� =   ��� o    �;�; 0 
thecontext 
theContext� m    �:
�: 
msng� L   
 �9�9  �<  � k    ��� ��� r    ��� m    �8�8 � o      �7�7 0 i  � ��� r    ��� m    �6
�6 boovfals� o      �5�5 0 variablefound variableFound� ��� V    E��� k   ( @�� ��� Z  ( :���4�3� E   ( 0��� n   ( +��� 1   ) +�2
�2 
pnam� o   ( )�1�1 0 
thecontext 
theContext� l  + /��0�/� n   + /��� 4   , /�.�
�. 
cobj� o   - .�-�- 0 i  � o   + ,�,�, 0 thevariables theVariables�0  �/  � r   3 6��� m   3 4�+
�+ boovtrue� o      �*�* 0 variablefound variableFound�4  �3  � ��)� r   ; @��� [   ; >��� o   ; <�(�( 0 i  � m   < =�'�' � o      �&�& 0 i  �)  � F    '��� l    ��%�$� A     ��� o    �#�# 0 i  � l   ��"�!� n    ��� 1    � 
�  
leng� o    �� 0 thevariables theVariables�"  �!  �%  �$  � l  # %���� H   # %�� o   # $�� 0 variablefound variableFound�  �  � ��� Z   F ������ H   F H�� o   F G�� 0 variablefound variableFound� L   K M�� o   K L�� 0 
thecontext 
theContext�  � k   P ��� ��� r   P \��� n  P Z��� I   Q Z���� $0 replacevariables replaceVariables� ��� n   Q T��� 1   R T�
� 
pnam� o   Q R�� 0 
thecontext 
theContext� ��� o   T U�� 0 thevariables theVariables� ��� o   U V�� "0 thereplacements theReplacements�  �  �  f   P Q� o      �� (0 desiredcontextname desiredContextName� ��� r   ] d��� n  ] b��� 2   ` b�
� 
FCct� l  ] `���� n   ] `��� 1   ^ `�
� 
ctnr� o   ] ^�� 0 
thecontext 
theContext�  �  � o      �
�
 $0 contextsinfolder contextsInFolder� ��� l  e e�	���	  �  �  � ��� r   e h��� m   e f�
� 
null� o      �� "0 positionoffound positionOfFound� ��� r   i m��� J   i k��  � o      �� 20 namesofcontextsinfolder namesOfContextsInFolder� ��� Y   n ������� k   { ��� ��� r   { ���� n   { �� � 1    �� 
�  
pnam  l  { ���� n   {  4   | ��
�� 
cobj o   } ~���� 0 i   o   { |���� $0 contextsinfolder contextsInFolder��  ��  � n        ;   � � o   � ����� 20 namesofcontextsinfolder namesOfContextsInFolder� �� Z  � �	���� =  � �

 l  � ����� n   � � 4   � ���
�� 
cobj o   � ����� 0 i   o   � ����� 20 namesofcontextsinfolder namesOfContextsInFolder��  ��   o   � ����� (0 desiredcontextname desiredContextName	 r   � � o   � ����� 0 i   o      ���� "0 positionoffound positionOfFound��  ��  ��  � 0 i  � m   q r���� � l  r v���� n   r v 1   s u��
�� 
leng o   r s���� $0 contextsinfolder contextsInFolder��  ��  �  �  l  � ���������  ��  ��   �� Z   � ��� >  � � o   � ����� "0 positionoffound positionOfFound m   � ���
�� 
null L   � � l  � ����� n   � �  4   � ���!
�� 
cobj! o   � ����� "0 positionoffound positionOfFound  o   � ����� $0 contextsinfolder contextsInFolder��  ��  ��   k   � �"" #$# r   � �%&% l  � �'����' n   � �()( 1   � ���
�� 
ctnr) o   � ����� 0 
thecontext 
theContext��  ��  & o      ���� 0 thecontainer theContainer$ *+* O   � �,-, r   � �./. I  � �����0
�� .corecrel****      � null��  0 ��12
�� 
kocl1 m   � ���
�� 
FCct2 ��34
�� 
insh3 l  � �5����5 n   � �676  ;   � �7 n   � �898 2  � ���
�� 
FCct9  g   � ���  ��  4 ��:��
�� 
prdt: K   � �;; ��<��
�� 
pnam< o   � ����� (0 desiredcontextname desiredContextName��  ��  / o      ���� 0 
newcontext 
newContext- o   � ����� 0 thecontainer theContainer+ =��= L   � �>> o   � ����� 0 
newcontext 
newContext��  ��  �  � m     ??�                                                                                  OFOC  alis    X  Macintosh HD               �0ڲH+     OOmniFocus.app                                                   ��>2        ����  	                Applications    �1�      �>Lr       O  (Macintosh HD:Applications: OmniFocus.app    O m n i F o c u s . a p p    M a c i n t o s h   H D  Applications/OmniFocus.app  / ��  � @A@ l     ��������  ��  ��  A BCB l     ��������  ��  ��  C DED i   # &FGF I      ��H���� $0 findthevariables findTheVariablesH I��I o      ���� 0 
theproject 
theProject��  ��  G k     �JJ KLK O     �MNM O    �OPO k   
 �QQ RSR r   
 TUT n   
 VWV 1    ��
�� 
FCnoW o   
 ���� 0 
theproject 
theProjectU o      ���� 0 thefullnote theFullNoteS XYX Z   Z[����Z =   \]\ o    ���� 0 thefullnote theFullNote] m    ��
�� 
msng[ L    ^^ J    ����  ��  ��  Y _`_ r    !aba m    ��
�� 
nullb o      ���� 0 thenote theNote` cdc Y   " Pe��fghe Z   2 Kij����i C   2 <klk n   2 6mnm 4   3 6��o
�� 
cparo o   4 5���� 0 i  n o   2 3���� 0 thefullnote theFullNotel o   6 ;����  0 variablesymbol variableSymbolj k   ? Gpp qrq r   ? Ests n   ? Cuvu 4   @ C��w
�� 
cparw o   A B���� 0 i  v o   ? @���� 0 thefullnote theFullNotet o      ���� 0 thenote theNoter x��x  S   F G��  ��  ��  �� 0 i  f l  % ,y����y I  % ,��z��
�� .corecnte****       ****z n   % ({|{ 2  & (��
�� 
cpar| o   % &���� 0 thefullnote theFullNote��  ��  ��  g m   , -���� h m   - .������d }~} Z  Q ^����� =  Q T��� o   Q R���� 0 thenote theNote� m   R S��
�� 
null� L   W Z�� J   W Y����  ��  ��  ~ ��� r   _ c��� J   _ a����  � o      ���� $0 cleanedvariables cleanedVariables� ��� l  d d��������  ��  ��  � ��� r   d v��� J   d r�� ��� b   d k��� m   d e�� ���   � o   e j����  0 variablesymbol variableSymbol� ���� o   k p����  0 variablesymbol variableSymbol��  � n     ��� 1   s u��
�� 
txdl�  f   r s� ��� r   w |��� n   w z��� 2   x z��
�� 
citm� o   w x���� 0 thenote theNote� o      ���� 0 thevariables theVariables� ��� r   } ���� J   } ����  � n     ��� 1   � ���
�� 
txdl�  f    �� ��� l  � ���������  ��  ��  � ��� Y   � ��������� Z   � �������� >  � ���� n   � ���� 4   � ����
�� 
cobj� o   � ����� 0 thevar theVar� o   � ����� 0 thevariables theVariables� m   � ��� ���  � r   � ���� n   � ���� 4   � ����
�� 
cobj� o   � ����� 0 thevar theVar� o   � ����� 0 thevariables theVariables� l     ���~� n      ���  ;   � �� o   � ��}�} $0 cleanedvariables cleanedVariables�  �~  ��  ��  �� 0 thevar theVar� m   � ��|�| � l  � ���{�z� n   � ���� 1   � ��y
�y 
leng� o   � ��x�x 0 thevariables theVariables�{  �z  ��  � ��w� l  � ��v�u�t�v  �u  �t  �w  P 1    �s
�s 
FCDoN m     ���                                                                                  OFOC  alis    X  Macintosh HD               �0ڲH+     OOmniFocus.app                                                   ��>2        ����  	                Applications    �1�      �>Lr       O  (Macintosh HD:Applications: OmniFocus.app    O m n i F o c u s . a p p    M a c i n t o s h   H D  Applications/OmniFocus.app  / ��  L ��r� L   � ��� o   � ��q�q $0 cleanedvariables cleanedVariables�r  E ��� l     �p�o�n�p  �o  �n  � ��� l     �m�l�k�m  �l  �k  � ��� i   ' *��� I      �j��i�j *0 findthereplacements findTheReplacements� ��h� o      �g�g 0 thevariables theVariables�h  �i  � k     \�� ��� O     Y��� O    X��� k   
 W�� ��� r   
 ��� J   
 �f�f  � o      �e�e "0 thereplacements theReplacements� ��� r    ��� m    �� ��� B S e l e c t   R e p l a c e m e n t s   f o r   V a r i a b l e s� o      �d�d 0 thetitle theTitle� ��c� Y    W��b���a� k     R�� ��� r     .��� b     ,��� b     *��� b     (��� b     #��� m     !�� ��� > W h a t   w o u l d   y o u   l i k e   t o   r e p l a c e  � 1   ! "�`
�` 
quot� l  # '��_�^� n   # '��� 4   $ '�]�
�] 
cobj� o   % &�\�\ 0 i  � o   # $�[�[ 0 thevariables theVariables�_  �^  � 1   ( )�Z
�Z 
quot� m   * +�� ���    w i t h ?� o      �Y�Y 0 thetext theText� ��X� Q   / R���� r   2 >��� n   2 ;��� 1   9 ;�W
�W 
ttxt� l  2 9	 �V�U	  I  2 9�T		
�T .sysodlogaskr        TEXT	 o   2 3�S�S 0 thetext theText	 �R	�Q
�R 
dtxt	 m   4 5		 �		  �Q  �V  �U  � l     	�P�O	 n      			  ;   < =	 o   ; <�N�N "0 thereplacements theReplacements�P  �O  � R      �M			

�M .ascrerr ****      � ****		 o      �L�L 0 	errortext 	errorText	
 �K	�J
�K 
errn	 o      �I�I 0 errornumber errorNumber�J  � Z   F R		�H�G	 =  F I			 o   F G�F�F 0 errornumber errorNumber	 m   G H�E�E��	 L   L N		 m   L M�D
�D boovfals�H  �G  �X  �b 0 i  � m    �C�C � l   	�B�A	 n    			 1    �@
�@ 
leng	 o    �?�? 0 thevariables theVariables�B  �A  �a  �c  � 1    �>
�> 
FCDo� m     		�                                                                                  OFOC  alis    X  Macintosh HD               �0ڲH+     OOmniFocus.app                                                   ��>2        ����  	                Applications    �1�      �>Lr       O  (Macintosh HD:Applications: OmniFocus.app    O m n i F o c u s . a p p    M a c i n t o s h   H D  Applications/OmniFocus.app  / ��  � 	�=	 L   Z \		 o   Z [�<�< "0 thereplacements theReplacements�=  � 			 l     �;�:�9�;  �:  �9  	 			 l     �8�7�6�8  �7  �6  	 			 i   + .			 I      �5	�4�5 &0 cleanexcessbreaks cleanExcessBreaks	 	 �3	  o      �2�2 0 thetext theText�3  �4  	 k     u	!	! 	"	#	" Z    	$	%�1�0	$ =    	&	'	& o     �/�/ 0 thetext theText	' m    �.
�. 
msng	% L    	(	( m    �-
�- 
msng�1  �0  	# 	)	*	) Z   	+	,�,�+	+ =   	-	.	- o    �*�* 0 thetext theText	. m    	/	/ �	0	0  	, L    	1	1 m    	2	2 �	3	3  �,  �+  	* 	4	5	4 Z   ,	6	7�)�(	6 =   #	8	9	8 l   !	:�'�&	: I   !�%	;�$
�% .corecnte****       ****	; n    	<	=	< 2   �#
�# 
cpar	= o    �"�" 0 thetext theText�$  �'  �&  	9 m   ! "�!�! 	7 L   & (	>	> o   & '� �  0 thetext theText�)  �(  	5 	?	@	? Y   - T	A�	B	C	D	A Z   = O	E	F��	E >  = C	G	H	G n   = A	I	J	I 4   > A�	K
� 
cpar	K o   ? @�� 0 i  	J o   = >�� 0 thetext theText	H m   A B	L	L �	M	M  	F k   F K	N	N 	O	P	O r   F I	Q	R	Q o   F G�� 0 i  	R o      �� 0 textends textEnds	P 	S�	S  S   J K�  �  �  � 0 i  	B l  0 7	T��	T I  0 7�	U�
� .corecnte****       ****	U n   0 3	V	W	V 2  1 3�
� 
cpar	W o   0 1�� 0 thetext theText�  �  �  	C m   7 8�� 	D m   8 9����	@ 	X	Y	X r   U \	Z	[	Z J   U X	\	\ 	]�	] o   U V�
� 
ret �  	[ 1   X [�
� 
txdl	Y 	^	_	^ r   ] l	`	a	` c   ] j	b	c	b n   ] h	d	e	d 7  ^ h�	f	g
� 
cpar	f m   b d�
�
 	g o   e g�	�	 0 textends textEnds	e o   ] ^�� 0 thetext theText	c m   h i�
� 
ctxt	a o      �� 0 
thenewtext 
theNewText	_ 	h	i	h r   m r	j	k	j m   m n	l	l �	m	m  	k 1   n q�
� 
txdl	i 	n�	n L   s u	o	o o   s t�� 0 
thenewtext 
theNewText�  	 	p	q	p l     ��� �  �  �   	q 	r	s	r l     ��������  ��  ��  	s 	t	u	t i   / 2	v	w	v I      �������� .0 checkforothertemplate checkForOtherTemplate��  ��  	w k    z	x	x 	y	z	y O    w	{	|	{ O   v	}	~	} k   
u		 	�	�	� r   
 	�	�	� l  
 	�����	� I  
 ��	���
�� .corecnte****       ****	� l  
 	�����	� 6 
 	�	�	� 2   
 ��
�� 
FCff	� l   	�����	� E    	�	�	� n   	�	�	� 1    ��
�� 
pnam	�  g    	� m    	�	� �	�	�  T e m p l a t e��  ��  ��  ��  ��  ��  ��  	� o      ���� 0 thecount theCount	� 	�	�	� Z    �	�	���	�	� l   9	�����	� =   9	�	�	� l   7	�����	� I   7��	���
�� .corecnte****       ****	� l   3	�����	� 6  3	�	�	� 2     ��
�� 
FCff	� F   ! 2	�	�	� l  " )	�����	� E   " )	�	�	� n  # %	�	�	� 1   # %��
�� 
pnam	�  g   # #	� m   & (	�	� �	�	�  T e m p l a t e��  ��  	� l  * 1	�����	� =  * 1	�	�	� n  + -	�	�	� 1   + -��
�� 
FCHi	�  g   + +	� m   . 0��
�� boovfals��  ��  ��  ��  ��  ��  ��  	� m   7 8����  ��  ��  	� k   < �	�	� 	�	�	� r   < J	�	�	� 6 < H	�	�	� 2   < ?��
�� 
FCff	� l  @ G	�����	� =  @ G	�	�	� n  A C	�	�	� 1   A C��
�� 
FCHi	�  g   A A	� m   D F��
�� boovfals��  ��  	� o      ���� (0 templatefolderlist templateFolderList	� 	�	�	� r   K O	�	�	� J   K M����  	� o      ���� 00 templatefoldernamelist templateFolderNameList	� 	�	�	� X   P �	���	�	� k   ` �	�	� 	�	�	� r   ` c	�	�	� m   ` a	�	� �	�	�  	� o      ���� 0 nextlistitem nextListItem	� 	�	�	� Z  d u	�	�����	� =  d k	�	�	� l  d i	�����	� n   d i	�	�	� 1   g i��
�� 
pcls	� n  d g	�	�	� 1   e g��
�� 
ctnr	� o   d e���� 0 	thefolder 	theFolder��  ��  	� m   i j��
�� 
FCAr	� r   n q	�	�	� m   n o	�	� �	�	� !�  	� o      ���� 0 nextlistitem nextListItem��  ��  	� 	�	�	� r   v }	�	�	� b   v {	�	�	� o   v w���� 0 nextlistitem nextListItem	� l  w z	�����	� n   w z	�	�	� 1   x z��
�� 
pnam	� o   w x���� 0 	thefolder 	theFolder��  ��  	� o      ���� 0 nextlistitem nextListItem	� 	���	� r   ~ �	�	�	� o   ~ ���� 0 nextlistitem nextListItem	� l     	�����	� n      	�	�	�  ;   � �	� o    ����� 00 templatefoldernamelist templateFolderNameList��  ��  ��  �� 0 	thefolder 	theFolder	� o   S T���� (0 templatefolderlist templateFolderList	� 	�	�	� r   � �	�	�	� I  � ���	�	�
�� .gtqpchltns    @   @ ns  	� o   � ����� 00 templatefoldernamelist templateFolderNameList	� ��	�	�
�� 
appr	� m   � �	�	� �	�	� 2 C h o o s e   T e m p l a t e   F o l d e r ( s )	� ��	�	�
�� 
prmp	� m   � �	�	� �	�	� � N o   o b v i o u s   t e m p l a t e   f o l d e r s   w e r e   f o u n d .   P l e a s e   s e l e c t   t h e   f o l d e r ( s )   i n   w h i c h   y o u   s t o r e   t e m p l a t e s .	� ��	�	�
�� 
okbt	� m   � �	�	� �	�	� , S e t   a s   T e m p l a t e   F o l d e r	� ��	���
�� 
mlsl	� m   � ���
�� boovtrue��  	� o      ���� 00 selectedtemplatefolder selectedTemplateFolder	� 	�	�	� Z  � �	�	�����	� =  � �	�	�	� o   � ����� 00 selectedtemplatefolder selectedTemplateFolder	� m   � ���
�� boovfals	� L   � �����  ��  ��  	� 	�	�	� r   � �	�
 	� n  � �


 I   � ���
���� (0 selectionpositions selectionPositions
 


 o   � ����� 00 selectedtemplatefolder selectedTemplateFolder
 


 o   � ����� 00 templatefoldernamelist templateFolderNameList
 
��
 m   � ���
�� boovtrue��  ��  
  f   � �
  o      ���� 00 templatefolderposition templateFolderPosition	� 
	


	 r   � �


 J   � �����  
 o      ���� 20 existingtemplatefolders existingTemplateFolders

 
��
 Y   � �
��

��
 r   � �


 n   � �


 4   � ���

�� 
cobj
 o   � ����� 0 i  
 o   � ����� (0 templatefolderlist templateFolderList
 l     
����
 n      


  ;   � �
 o   � ����� 20 existingtemplatefolders existingTemplateFolders��  ��  �� 0 i  
 m   � ����� 
 l  � �
����
 n   � �


 1   � ���
�� 
leng
 o   � ����� 00 templatefolderposition templateFolderPosition��  ��  ��  ��  ��  	� r   � �


 6 � �


 2   � ���
�� 
FCff
 F   � �
 
!
  l  � �
"����
" E   � �
#
$
# n  � �
%
&
% 1   � ���
�� 
pnam
&  g   � �
$ m   � �
'
' �
(
(  T e m p l a t e��  ��  
! l  � �
)����
) =  � �
*
+
* n  � �
,
-
, 1   � ���
�� 
FCHi
-  g   � �
+ m   � ���
�� boovfals��  ��  
 o      ���� 20 existingtemplatefolders existingTemplateFolders	� 
.
/
. l  � ���������  ��  ��  
/ 
0
1
0 r   �
2
3
2 J   � ����  
3 o      ���� *0 oldtemplateprojects oldTemplateProjects
1 
4
5
4 Y  F
6��
7
8��
6 r  A
9
:
9 l ?
;����
; 6?
<
=
< 2  ��
�� 
FCfx
= F  >
>
?
> F  1
@
A
@ l $
B����
B = $
C
D
C n 
E
F
E 1  ��
�� 
ctnr
F  g  
D l #
G����
G n  #
H
I
H 4   #��
J
�� 
cobj
J o  !"�� 0 i  
I o   �~�~ 20 existingtemplatefolders existingTemplateFolders��  ��  ��  ��  
A l %0
K�}�|
K > %0
L
M
L n &*
N
O
N 1  &*�{
�{ 
FCPs
O  g  &&
M m  +/�z
�z FCPsFCPD�}  �|  
? l 2=
P�y�x
P > 2=
Q
R
Q n 37
S
T
S 1  37�w
�w 
FCPs
T  g  33
R m  8<�v
�v FCPsFCPd�y  �x  ��  ��  
: o      �u�u 40 possibletemplateprojects possibleTemplateProjects�� 0 i  
7 m  �t�t 
8 l 
U�s�r
U n  
V
W
V 1  �q
�q 
leng
W o  �p�p 20 existingtemplatefolders existingTemplateFolders�s  �r  ��  
5 
X�o
X Y  Gu
Y�n
Z
[�m
Y Z Vp
\
]�l�k
\ E  Vb
^
_
^ l V^
`�j�i
` n  V^
a
b
a 1  Z^�h
�h 
FCno
b l VZ
c�g�f
c n  VZ
d
e
d 4  WZ�e
f
�e 
cobj
f o  XY�d�d 0 i  
e o  VW�c�c 40 possibletemplateprojects possibleTemplateProjects�g  �f  �j  �i  
_ m  ^a
g
g �
h
h  �
] r  el
i
j
i l ei
k�b�a
k n  ei
l
m
l 4  fi�`
n
�` 
cobj
n o  gh�_�_ 0 i  
m o  ef�^�^ 40 possibletemplateprojects possibleTemplateProjects�b  �a  
j l     
o�]�\
o n      
p
q
p  ;  jk
q o  ij�[�[ *0 oldtemplateprojects oldTemplateProjects�]  �\  �l  �k  �n 0 i  
Z m  JK�Z�Z 
[ l KQ
r�Y�X
r n  KQ
s
t
s 1  LP�W
�W 
leng
t o  KL�V�V 40 possibletemplateprojects possibleTemplateProjects�Y  �X  �m  �o  	~ 1    �U
�U 
FCDo	| m     
u
u�                                                                                  OFOC  alis    X  Macintosh HD               �0ڲH+     OOmniFocus.app                                                   ��>2        ����  	                Applications    �1�      �>Lr       O  (Macintosh HD:Applications: OmniFocus.app    O m n i F o c u s . a p p    M a c i n t o s h   H D  Applications/OmniFocus.app  / ��  	z 
v�T
v L  xz
w
w o  xy�S�S *0 oldtemplateprojects oldTemplateProjects�T  	u 
x
y
x l     �R�Q�P�R  �Q  �P  
y 
z
{
z l     �O�N�M�O  �N  �M  
{ 
|
}
| i   3 6
~

~ I      �L
��K�L 20 adjustoldtemplatesyntax adjustOldTemplateSyntax
� 
��J
� o      �I�I *0 oldtemplateprojects oldTemplateProjects�J  �K  
 O    
�
�
� O   
�
�
� k   

�
� 
�
�
� Y   
 �
��H
�
��G
� O    �
�
�
� k    �
�
� 
�
�
� r    #
�
�
� m    
�
� �
�
�  �
� n     
�
�
� 1     "�F
�F 
txdl
�  f     
� 
�
�
� r   $ )
�
�
� n  $ '
�
�
� 1   % '�E
�E 
pnam
�  g   $ %
� o      �D�D 0 tempname tempName
� 
�
�
� r   * /
�
�
� l  * -
��C�B
� n   * -
�
�
� 2   + -�A
�A 
citm
� o   * +�@�@ 0 tempname tempName�C  �B  
� o      �?�? 0 tempname tempName
� 
�
�
� r   0 5
�
�
� n  0 3
�
�
� 1   1 3�>
�> 
FCno
�  g   0 1
� o      �=�= 0 tempnote tempNote
� 
�
�
� r   6 ;
�
�
� l  6 9
��<�;
� n   6 9
�
�
� 2   7 9�:
�: 
citm
� o   6 7�9�9 0 tempnote tempNote�<  �;  
� o      �8�8 0 tempnote tempNote
� 
�
�
� r   < E
�
�
� o   < A�7�7  0 variablesymbol variableSymbol
� n     
�
�
� 1   B D�6
�6 
txdl
�  f   A B
� 
�
�
� r   F K
�
�
� c   F I
�
�
� o   F G�5�5 0 tempname tempName
� m   G H�4
�4 
TEXT
� o      �3�3 0 tempname tempName
� 
�
�
� r   L Q
�
�
� c   L O
�
�
� o   L M�2�2 0 tempnote tempNote
� m   M N�1
�1 
TEXT
� o      �0�0 0 tempnote tempNote
� 
�
�
� r   R W
�
�
� m   R S
�
� �
�
�  �
� n     
�
�
� 1   T V�/
�/ 
txdl
�  f   S T
� 
�
�
� r   X ]
�
�
� l  X [
��.�-
� n   X [
�
�
� 2   Y [�,
�, 
citm
� o   X Y�+�+ 0 tempname tempName�.  �-  
� o      �*�* 0 tempname tempName
� 
�
�
� r   ^ c
�
�
� l  ^ a
��)�(
� n   ^ a
�
�
� 2   _ a�'
�' 
citm
� o   ^ _�&�& 0 tempnote tempNote�)  �(  
� o      �%�% 0 tempnote tempNote
� 
�
�
� r   d i
�
�
� m   d e
�
� �
�
�  
� n     
�
�
� 1   f h�$
�$ 
txdl
�  f   e f
� 
�
�
� r   j q
�
�
� c   j m
�
�
� o   j k�#�# 0 tempname tempName
� m   k l�"
�" 
TEXT
� n     
�
�
� 1   n p�!
�! 
pnam
�  g   m n
� 
�
�
� r   r y
�
�
� c   r u
�
�
� o   r s� �  0 tempnote tempNote
� m   s t�
� 
TEXT
� n     
�
�
� 1   v x�
� 
FCno
�  g   u v
� 
��
� Y   z �
��
�
��
� O   � �
�
�
� k   � �
�
� 
�
�
� r   � �
�
�
� m   � �
�
� �
�
�  �
� n     
�
�
� 1   � ��
� 
txdl
�  f   � �
�    r   � � n  � � 1   � ��
� 
pnam  g   � � o      �� 0 tempname tempName  r   � �	 l  � �
��
 n   � � 2   � ��
� 
citm o   � ��� 0 tempname tempName�  �  	 o      �� 0 tempname tempName  r   � � n  � � 1   � ��
� 
FCno  g   � � o      �� 0 tempnote tempNote  r   � � l  � ��� n   � � 2   � ��
� 
citm o   � ��� 0 tempnote tempNote�  �   o      �� 0 tempnote tempNote  r   � � o   � ���  0 variablesymbol variableSymbol n      1   � ��

�
 
txdl  f   � �  !  r   � �"#" c   � �$%$ o   � ��	�	 0 tempname tempName% m   � ��
� 
TEXT# o      �� 0 tempname tempName! &'& r   � �()( c   � �*+* o   � ��� 0 tempnote tempNote+ m   � ��
� 
TEXT) o      �� 0 tempnote tempNote' ,-, r   � �./. m   � �00 �11  �/ n     232 1   � ��
� 
txdl3  f   � �- 454 r   � �676 l  � �8��8 n   � �9:9 2   � �� 
�  
citm: o   � ����� 0 tempname tempName�  �  7 o      ���� 0 tempname tempName5 ;<; r   � �=>= l  � �?����? n   � �@A@ 2   � ���
�� 
citmA o   � ����� 0 tempnote tempNote��  ��  > o      ���� 0 tempnote tempNote< BCB r   � �DED m   � �FF �GG  E n     HIH 1   � ���
�� 
txdlI  f   � �C JKJ r   � �LML c   � �NON o   � ����� 0 tempname tempNameO m   � ���
�� 
TEXTM n     PQP 1   � ���
�� 
pnamQ  g   � �K R��R r   � �STS c   � �UVU o   � ����� 0 tempnote tempNoteV m   � ���
�� 
TEXTT n     WXW 1   � ���
�� 
FCnoX  g   � ���  
� 4   � ���Y
�� 
FCftY o   � ����� 0 i  � 0 i  
� m   } ~���� 
� l  ~ �Z����Z I  ~ ���[��
�� .corecnte****       ****[ n  ~ �\]\ 2   ���
�� 
FCft]  g   ~ ��  ��  ��  �  �  
� n    ^_^ 4    ��`
�� 
cobj` o    ���� 0 i  _ o    ���� *0 oldtemplateprojects oldTemplateProjects�H 0 i  
� m    ���� 
� l   a����a n    bcb 1    ��
�� 
lengc o    ���� *0 oldtemplateprojects oldTemplateProjects��  ��  �G  
� d��d r   �efe m   � �gg �hh  f n     iji 1   ���
�� 
txdlj  f   � ���  
� 1    ��
�� 
FCDo
� m     kk�                                                                                  OFOC  alis    X  Macintosh HD               �0ڲH+     OOmniFocus.app                                                   ��>2        ����  	                Applications    �1�      �>Lr       O  (Macintosh HD:Applications: OmniFocus.app    O m n i F o c u s . a p p    M a c i n t o s h   H D  Applications/OmniFocus.app  / ��  
} lml l     ��������  ��  ��  m non l     ��������  ��  ��  o pqp i   7 :rsr I      ��t���� 80 checkingfordateinformation checkingForDateInformationt u��u o      ���� 0 theitem theItem��  ��  s O    �vwv O   �xyx O   
�z{z O   �|}| k   �~~ � r    ��� l   ������ n    ��� 1    ��
�� 
FCno� o    ���� 0 theitem theItem��  ��  � o      ���� 0 thenote theNote� ��� s    !��� o    ���� 0 thenote theNote� o      ���� "0 theoriginalnote theOriginalNote� ��� l  " "��������  ��  ��  � ��� r   " %��� m   " #��
�� 
null� o      ���� 0 
dueorstart 
dueOrStart� ��� r   & )��� m   & '��
�� boovfals� o      ���� 0 
askfordate 
askForDate� ��� r   * -��� m   * +��
�� boovfals� o      ���� &0 relativetoproject relativeToProject� ��� l  . .��������  ��  ��  � ��� Z   . G������ l  . 1������ E   . 1��� o   . /���� 0 thenote theNote� m   / 0�� ���  D u e��  ��  � r   4 7��� m   4 5�� ���  d u e� o      ���� 0 
dueorstart 
dueOrStart� ��� l  : =������ E   : =��� o   : ;���� 0 thenote theNote� m   ; <�� ��� 
 S t a r t��  ��  � ���� r   @ C��� m   @ A�� ��� 
 s t a r t� o      ���� 0 
dueorstart 
dueOrStart��  ��  � ��� Z  H U������� E   H K��� o   H I���� 0 thenote theNote� m   I J�� ���  A s k� r   N Q��� m   N O��
�� boovtrue� o      ���� 0 
askfordate 
askForDate��  ��  � ��� Z  V c������� E   V Y��� o   V W���� 0 thenote theNote� m   W X�� ���  P r o j e c t� r   \ _��� m   \ ]��
�� boovtrue� o      ���� &0 relativetoproject relativeToProject��  ��  � ��� l  d d��������  ��  ��  � ��� Z   dV������ =  d g��� o   d e���� 0 
dueorstart 
dueOrStart� m   e f��
�� 
null� L   j l�� m   j k��
�� 
msng��  � k   oV�� ��� r   o t��� n   o r��� 2   p r��
�� 
cpar� o   o p���� 0 thenote theNote� o      ���� &0 thenoteparagraphs theNoteParagraphs� ��� Y   u ��������� Z   � �������� G   � ���� l  � ������� C   � ���� n   � ���� 4   � ����
�� 
cobj� o   � ����� 0 i  � o   � ����� &0 thenoteparagraphs theNoteParagraphs� m   � ��� ���  D u e��  ��  � l  � ������� C   � ���� n   � ���� 4   � ����
�� 
cobj� o   � ����� 0 i  � o   � ����� &0 thenoteparagraphs theNoteParagraphs� m   � ��� ��� 
 S t a r t��  ��  � k   � ��� ��� r   � ���� n   � ���� 4   � ����
�� 
cobj� o   � ����� 0 i  � o   � ����� &0 thenoteparagraphs theNoteParagraphs� o      ���� 0 thenote theNote� ����  S   � ���  ��  ��  �� 0 i  � m   x y���� � l  y }������ n   y }��� 1   z |��
�� 
leng� o   y z���� &0 thenoteparagraphs theNoteParagraphs��  ��  ��  � ���� Z   �V� ��� o   � ����� 0 
askfordate 
askForDate  k   �  r   � � c   � � l  � �	����	 n   � �

 1   � ���
�� 
pcls o   � ����� 0 theitem theItem��  ��   m   � ���
�� 
TEXT o      ���� 0 classofitem classOfItem  r   � � b   � � b   � � b   � � b   � � b   � � b   � � b   � � b   � � m   � �   �!! 0 W h e n   w o u l d   y o u   l i k e   t h e   o   � ����� 0 
dueorstart 
dueOrStart m   � �"" �##    d a t e   o f   t h e   o   � ����� 0 classofitem classOfItem m   � �$$ �%%    1   � ��
� 
quot l  � �&�~�}& n   � �'(' 1   � ��|
�| 
pnam( o   � ��{�{ 0 theitem theItem�~  �}   1   � ��z
�z 
quot m   � �)) �** �   t o   b e ?   Y o u   c a n   u s e   r e l a t i v e   ( i . e . ,   " 3 d   2 p m " )   o r   a b s o l u t e   ( i . e . ,   " J a n   1 9   1 5 : 0 0 " )   d a t e s   i n   y o u r   i n p u t . o      �y�y 0 displaytext displayText +�x+ Q   �,-., r   � �/0/ n   � �121 1   � ��w
�w 
ttxt2 l  � �3�v�u3 I  � ��t45
�t .sysodlogaskr        TEXT4 o   � ��s�s 0 displaytext displayText5 �r6�q
�r 
dtxt6 m   � �77 �88  1 d   1 2 a m�q  �v  �u  0 o      �p�p 0 	inputdate 	inputDate- R      �o9:
�o .ascrerr ****      � ****9 o      �n�n 0 	errortext 	errorText: �m;�l
�m 
errn; o      �k�k 0 errornumber errorNumber�l  . Z   �<=�j�i< =  �>?> o   � ��h�h 0 errornumber errorNumber? m   ��g�g��= L  @@ m  �f
�f 
msng�j  �i  �x  ��   k  VAA BCB r  3DED J  1FF GHG m  II �JJ  D u e :H KLK m  MM �NN  S t a r t :L OPO m  QQ �RR  D u eP STS m  UU �VV 
 S t a r tT WXW m  YY �ZZ  P r o j e c tX [\[ m  !]] �^^ 
 t o d a y\ _`_ m  !$aa �bb  a t` cdc m  $'ee �ff  +d ghg m  '*ii �jj  -h k�ek m  *-ll �mm  �e  E o      �d�d (0 possibledelimiters possibleDelimitersC non r  4;pqp o  45�c�c (0 possibledelimiters possibleDelimitersq n     rsr 1  6:�b
�b 
txdls  f  56o tut s  <Dvwv n  <Axyx 2  =A�a
�a 
citmy o  <=�`�` 0 thenote theNotew o      �_�_ 0 tempdate tempDateu z{z r  EN|}| m  EH~~ �  } n     ��� 1  IM�^
�^ 
txdl�  f  HI{ ��]� r  OV��� c  OT��� o  OP�\�\ 0 tempdate tempDate� m  PS�[
�[ 
TEXT� o      �Z�Z 0 	inputdate 	inputDate�]  ��  � ��� l WW�Y�X�W�Y  �X  �W  � ��� r  W_��� n W]��� I  X]�V��U�V 0 englishtime englishTime� ��T� o  XY�S�S 0 	inputdate 	inputDate�T  �U  �  f  WX� o      �R�R "0 secondsdeferred secondsDeferred� ��� Z `l���Q�P� A  `c��� o  `a�O�O "0 secondsdeferred secondsDeferred� m  ab�N�N  � L  fh�� m  fg�M
�M 
msng�Q  �P  � ��� Z  m���L�� H  mo�� o  mn�K�K &0 relativetoproject relativeToProject� k  r��� ��� r  r{��� l rw��J�I� I rw�H�G�F
�H .misccurdldt    ��� null�G  �F  �J  �I  � o      �E�E 0 desireddate desiredDate� ��� r  |���� m  |}�D�D  � n      ��� 1  ���C
�C 
time� o  }��B�B 0 desireddate desiredDate� ��A� r  ����� [  ����� o  ���@�@ 0 desireddate desiredDate� o  ���?�? "0 secondsdeferred secondsDeferred� o      �>�> 0 desireddate desiredDate�A  �L  � k  ��� ��� Z �����=�<� = ����� n  ����� 1  ���;
�; 
pcls� o  ���:�: 0 theitem theItem� m  ���9
�9 
FCpr� L  ���� m  ���8
�8 
msng�=  �<  � ��7� Z  ����6�� = ����� o  ���5�5 0 
dueorstart 
dueOrStart� m  ���� ���  d u e� k  ���� ��� r  ����� n  ����� 1  ���4
�4 
FCDd� n  ����� 1  ���3
�3 
FCPr� o  ���2�2 0 theitem theItem� o      �1�1 0 relativedate relativeDate� ��� Z  �����0�/� = ����� o  ���.�. 0 relativedate relativeDate� m  ���-
�- 
msng� L  ���� m  ���,
�, 
msng�0  �/  � ��+� r  ����� \  ����� o  ���*�* 0 relativedate relativeDate� o  ���)�) "0 secondsdeferred secondsDeferred� o      �(�( 0 desireddate desiredDate�+  �6  � k  ��� ��� r  ����� n  ����� 1  ���'
�' 
FCDs� n  ����� 1  ���&
�& 
FCPr� o  ���%�% 0 theitem theItem� o      �$�$ 0 relativedate relativeDate� ��� Z  ����#�"� = ����� o  ���!�! 0 relativedate relativeDate� m  ��� 
�  
msng� k  ���� ��� r  ����� l ������ I �����
� .misccurdldt    ��� null�  �  �  �  � o      �� 0 relativedate relativeDate� ��� r  ����� m  ����  � n      ��� 1  ���
� 
time� o  ���� 0 relativedate relativeDate�  �#  �"  � ��� r  ��� [  	��� o  �� 0 relativedate relativeDate� o  �� "0 secondsdeferred secondsDeferred� o      �� 0 desireddate desiredDate�  �7  � ��� l ����  �  �  � ��� Z  ������ l ���� > ��� n  ��� 1  �

�
 
pcls� o  �	�	 0 theitem theItem� m  �
� 
FCpr�  �  � Z  � �  F  1 =  o  �� 0 
dueorstart 
dueOrStart m   �  D u e l "-	��	 > "-

 n  "+ 1  '+�
� 
FCDd n  "' 1  #'�
� 
FCPr o  "#�� 0 theitem theItem m  +,� 
�  
msng�  �   Z  4��� A  4= o  47���� 0 desireddate desiredDate l 7<���� I 7<������
�� .misccurdldt    ��� null��  ��  ��  ��   I @_��
�� .sysodisAaleR        TEXT b  @U b  @Q b  @M b  @G m  @C   �!! f B a s e d   o n   t h e   i n f o r m a t i o n   p r o v i d e d ,   t h e   d u e   d a t e   o f   1  CF��
�� 
quot l GL"����" n  GL#$# 1  HL��
�� 
pnam$ o  GH���� 0 theitem theItem��  ��   1  MP��
�� 
quot m  QT%% �&& �   i s   i n   t h e   p a s t .   Y o u   m i g h t   w a n t   t o   r e v i e w   t h e   n e w   i n s t a n c e   o f   t h e   p r o j e c t . ��'��
�� 
givu' m  X[���� 
��   ()( ?  bo*+* o  be���� 0 desireddate desiredDate+ n  en,-, 1  jn��
�� 
FCDd- n  ej./. 1  fj��
�� 
FCPr/ o  ef���� 0 theitem theItem) 0��0 I r���12
�� .sysodisAaleR        TEXT1 b  r�343 b  r�565 b  r787 b  ry9:9 m  ru;; �<< f B a s e d   o n   t h e   i n f o r m a t i o n   p r o v i d e d ,   t h e   d u e   d a t e   o f  : 1  ux��
�� 
quot8 l y~=����= n  y~>?> 1  z~��
�� 
pnam? o  yz���� 0 theitem theItem��  ��  6 1  ���
�� 
quot4 m  ��@@ �AA �   i s   a f t e r   t h e   d u e   d a t e   o f   i t s   c o n t a i n i n g   p r o j e c t .   Y o u   m i g h t   w a n t   t o   r e v i e w   t h e   n e w   i n s t a n c e   o f   t h e   p r o j e c t .2 ��B��
�� 
givuB m  ������ 
��  ��  ��   CDC l ��E����E > ��FGF n  ��HIH 1  ����
�� 
FCDdI n  ��JKJ 1  ����
�� 
FCPrK o  ������ 0 theitem theItemG m  ����
�� 
msng��  ��  D L��L Z  ��MN����M ?  ��OPO o  ������ 0 desireddate desiredDateP n  ��QRQ 1  ����
�� 
FCDdR n  ��STS 1  ����
�� 
FCPrT o  ������ 0 theitem theItemN I ����UV
�� .sysodisAaleR        TEXTU b  ��WXW b  ��YZY b  ��[\[ b  ��]^] m  ��__ �`` j B a s e d   o n   t h e   i n f o r m a t i o n   p r o v i d e d ,   t h e   s t a r t   d a t e   o f  ^ 1  ����
�� 
quot\ l ��a����a n  ��bcb 1  ����
�� 
pnamc o  ������ 0 theitem theItem��  ��  Z 1  ����
�� 
quotX m  ��dd �ee �   i s   a f t e r   t h e   d u e   d a t e   o f   i t s   c o n t a i n i n g   p r o j e c t .   Y o u   m i g h t   w a n t   t o   r e v i e w   t h e   n e w   i n s t a n c e   o f   t h e   p r o j e c t .V ��f��
�� 
givuf m  ������ 
��  ��  ��  ��  �  �  �  � ghg l ����������  ��  ��  h iji r  ��klk l ��m����m n  ��non 1  ����
�� 
lengo n  ��pqp 2 ����
�� 
cparq o  ������ "0 theoriginalnote theOriginalNote��  ��  l o      ���� 0 numparagraphs numParagraphsj rsr Y  �"t��uv��t Z  �wx����w G  �yzy l � {����{ C  � |}| n  ��~~ 4  �����
�� 
cpar� o  ������ 0 i   o  ������ "0 theoriginalnote theOriginalNote} m  ���� ���  d u e��  ��  z l ������ C  ��� n  ��� 4  ���
�� 
cpar� o  ���� 0 i  � o  ���� "0 theoriginalnote theOriginalNote� m  
�� ��� 
 s t a r t��  ��  x k  �� ��� r  ��� o  ���� 0 i  � o      ���� 0 datespot dateSpot� ����  S  ��  ��  ��  �� 0 i  u m  ������ v o  ������ 0 numparagraphs numParagraphs��  s ��� r  #.��� J  #(�� ���� o  #&��
�� 
ret ��  � n     ��� 1  )-��
�� 
txdl�  f  ()� ��� Z  /������ = /4��� o  /2���� 0 datespot dateSpot� m  23���� � Z  7\������ = 7@��� l 7>������ I 7>�����
�� .corecnte****       ****� n  7:��� 2 8:��
�� 
cpar� o  78���� "0 theoriginalnote theOriginalNote��  ��  ��  � m  >?���� � r  CH��� m  CF�� ���  � o      ���� 0 thenote theNote��  � r  K\��� c  KZ��� l KV������ n  KV��� 7 LV����
�� 
cpar� m  PR���� � m  SU������� l KL������ o  KL���� "0 theoriginalnote theOriginalNote��  ��  ��  ��  � m  VY��
�� 
TEXT� o      ���� 0 thenote theNote� ��� = _f��� o  _b���� 0 datespot dateSpot� o  be���� 0 numparagraphs numParagraphs� ���� r  i|��� c  iz��� l iv������ n  iv��� l jv������ 7 jv����
�� 
cpar� m  np���� � m  qu��������  ��  � o  ij���� "0 theoriginalnote theOriginalNote��  ��  � m  vy��
�� 
TEXT� o      ���� 0 thenote theNote��  � r  ���� c  ���� l ������� b  ���� l ������� n  ���� l �������� 7 ������
�� 
cpar� m  ������ � l �����~� \  ����� o  ���}�} 0 datespot dateSpot� m  ���|�| �  �~  ��  ��  � o  ��{�{ "0 theoriginalnote theOriginalNote��  ��  � l ����z�y� n  ����� l ����x�w� 7 ���v��
�v 
cpar� l ����u�t� [  ����� o  ���s�s 0 datespot dateSpot� m  ���r�r �u  �t  � m  ���q�q���x  �w  � o  ���p�p "0 theoriginalnote theOriginalNote�z  �y  ��  ��  � m  ���o
�o 
TEXT� o      �n�n 0 thenote theNote� ��� r  ����� m  ���� ���  � n     ��� 1  ���m
�m 
txdl�  f  ��� ��l� L  ���� J  ���� ��� o  ���k�k 0 desireddate desiredDate� ��� o  ���j�j 0 
dueorstart 
dueOrStart� ��i� o  ���h�h 0 thenote theNote�i  �l  } 1    �g
�g 
FCcn{ 4  
 �f�
�f 
FCdw� m    �e�e y 1    �d
�d 
FCDow m     ���                                                                                  OFOC  alis    X  Macintosh HD               �0ڲH+     OOmniFocus.app                                                   ��>2        ����  	                Applications    �1�      �>Lr       O  (Macintosh HD:Applications: OmniFocus.app    O m n i F o c u s . a p p    M a c i n t o s h   H D  Applications/OmniFocus.app  / ��  q ��� l     �c�b�a�c  �b  �a  � ��� l     �`�_�^�`  �_  �^  � ��� i   ; >��� I      �]��\�] 0 englishtime englishTime� ��[� o      �Z�Z 0 datedesired dateDesired�[  �\  � k    
�� ��� l     �Y�X�W�Y  �X  �W  � � � r      m     �V�V   o      �U�U 0 
monthfound 
monthFound   r     m    �T�T   o      �S�S 0 weekdayfound weekdayFound  l   �R	
�R  	 Z T Solves an issue with the treatment of leading zeros for the minutes (i.e., 12:01am)   
 � �   S o l v e s   a n   i s s u e   w i t h   t h e   t r e a t m e n t   o f   l e a d i n g   z e r o s   f o r   t h e   m i n u t e s   ( i . e . ,   1 2 : 0 1 a m )  r     m    	�Q
�Q boovfals o      �P�P &0 minuteleadingzero minuteLeadingZero  l   �O�N�M�O  �N  �M    l   �L�L   = 7 Figures out if the user excluded any of the components    � n   F i g u r e s   o u t   i f   t h e   u s e r   e x c l u d e d   a n y   o f   t h e   c o m p o n e n t s  r     m    �K
�K boovfals o      �J�J 0 timemissing timeMissing  r     m    �I
�I boovfals o      �H�H 0 daysmissing daysMissing   r    !"! m    �G
�G boovfals" o      �F�F 0 weeksmissing weeksMissing  #$# l   �E�D�C�E  �D  �C  $ %&% l   �B'(�B  ' 1 + Sets up the delimiters for different items   ( �)) V   S e t s   u p   t h e   d e l i m i t e r s   f o r   d i f f e r e n t   i t e m s& *+* r    !,-, J    .. /0/ m    11 �22  a m0 343 m    55 �66  p m4 787 m    99 �::  a8 ;<; m    == �>>  p< ?�A? m    @@ �AA  :�A  - o      �@�@  0 timedelimiters timeDelimiters+ BCB r   " )DED J   " 'FF GHG m   " #II �JJ  d a y sH KLK m   # $MM �NN  d a yL O�?O m   $ %PP �QQ  d�?  E o      �>�> 0 daydelimiters dayDelimitersC RSR r   * 1TUT J   * /VV WXW m   * +YY �ZZ 
 w e e k sX [\[ m   + ,]] �^^  w e e k\ _�=_ m   , -`` �aa  w�=  U o      �<�<  0 weekdelimiters weekDelimitersS bcb r   2 Tded J   2 Rff ghg m   2 3ii �jj  J a nh klk m   3 4mm �nn  F e bl opo m   4 5qq �rr  M a rp sts m   5 6uu �vv  A p rt wxw m   6 9yy �zz  M a yx {|{ m   9 <}} �~~  J u n| � m   < ?�� ���  J u l� ��� m   ? B�� ���  A u g� ��� m   B E�� ���  S e p� ��� m   E H�� ���  O c t� ��� m   H K�� ���  N o v� ��;� m   K N�� ���  D e c�;  e o      �:�: "0 monthdelimiters monthDelimitersc ��� r   U p��� J   U n�� ��� m   U X�� ���  S u n� ��� m   X [�� ���  M o n� ��� m   [ ^�� ���  T u e� ��� m   ^ a�� ���  W e d� ��� m   a d�� ���  T h u� ��� m   d g�� ���  F r i� ��9� m   g j�� ���  S a t�9  � o      �8�8 &0 weekdaydelimiters weekdayDelimiters� ��� r   q {��� J   q y�� ��� m   q t�� ��� 
 T o d a y� ��7� m   t w�� ���  T o m o r r o w�7  � o      �6�6 <0 specialrelativedaydelimiters specialRelativeDayDelimiters� ��� r   | ���� J   | ��� ��� m   | �� ���   � ��� m    ��� ���  t h� ��� m   � ��� ���  s t� ��� m   � ��� ���  r d� ��5� m   � ��� ���  n d�5  � o      �4�4 "0 otherdelimiters otherDelimiters� ��� l  � ��3�2�1�3  �2  �1  � ��� r   � ���� m   � ��� ���  u n k n o w n� o      �0�0 0 inthe inThe� ��� r   � ���� m   � ��/�/  � o      �.�. 00 howmanynumbersinputted howManyNumbersInputted� ��� r   � ���� J   � ��-�-  � o      �,�, 0 numlist numList� ��� l  � ��+�*�)�+  �*  �)  � ��� l  � ��(���(  � I C See if they gave an absolute, a relative one, or a day of the week   � ��� �   S e e   i f   t h e y   g a v e   a n   a b s o l u t e ,   a   r e l a t i v e   o n e ,   o r   a   d a y   o f   t h e   w e e k� ��� Y   � ���'���&� k   � ��� ��� Z   � ����%�$� E   � ���� o   � ��#�# 0 datedesired dateDesired� l  � ���"�!� n   � ���� 4   � ��  
�  
cobj  o   � ��� 0 i  � o   � ��� "0 monthdelimiters monthDelimiters�"  �!  � k   � �  r   � � o   � ��� 0 i   o      �� 0 
monthfound 
monthFound �  S   � ��  �%  �$  � � Z   � �	�� B   � �

 o   � ��� 0 i   l  � ��� n   � � 1   � ��
� 
leng o   � ��� &0 weekdaydelimiters weekdayDelimiters�  �  	 Z   � ��� E   � � o   � ��� 0 datedesired dateDesired l  � ��� n   � � 4   � ��
� 
cobj o   � ��� 0 i   o   � ��� &0 weekdaydelimiters weekdayDelimiters�  �   r   � � o   � ��
�
 0 i   o      �	�	 0 weekdayfound weekdayFound�  �  �  �  �  �' 0 i  � m   � ��� � l  � ��� n   � � 1   � ��
� 
leng o   � ��� "0 monthdelimiters monthDelimiters�  �  �&  �  l  � �����  �  �    l  � ��  !�     K E Getting rid of all the bits I could imagine being around the numbers   ! �"" �   G e t t i n g   r i d   o f   a l l   t h e   b i t s   I   c o u l d   i m a g i n e   b e i n g   a r o u n d   t h e   n u m b e r s #$# r   �%&% l  � '����' b   � ()( b   � �*+* b   � �,-, b   � �./. b   � �010 o   � ����� <0 specialrelativedaydelimiters specialRelativeDayDelimiters1 o   � ����� "0 monthdelimiters monthDelimiters/ o   � �����  0 weekdelimiters weekDelimiters- o   � ����� 0 daydelimiters dayDelimiters+ o   � �����  0 timedelimiters timeDelimiters) o   � ����� "0 otherdelimiters otherDelimiters��  ��  & 1   ��
�� 
txdl$ 232 r  454 n  676 2  ��
�� 
citm7 o  ���� 0 datedesired dateDesired5 o      ���� 0 	inputlist 	inputList3 898 l ��:;��  :   Resetting delimiters   ; �<< *   R e s e t t i n g   d e l i m i t e r s9 =>= r  ?@? J  AA B��B m  CC �DD  ��  @ 1  ��
�� 
txdl> EFE l ��������  ��  ��  F GHG l ��IJ��  I ( " Count how many numbers were given   J �KK D   C o u n t   h o w   m a n y   n u m b e r s   w e r e   g i v e nH LML Y  �N��OP��N k  .�QQ RSR Z  .yTU����T > .<VWV l .8X����X n  .8YZY 4  18��[
�� 
cobj[ o  47���� 0 i  Z o  .1���� 0 	inputlist 	inputList��  ��  W m  8;\\ �]]  U Q  ?u^_��^ k  Bl`` aba r  BTcdc c  BPefe l BLg����g n  BLhih 4  EL��j
�� 
cobjj o  HK���� 0 i  i o  BE���� 0 	inputlist 	inputList��  ��  f m  LO��
�� 
longd o      ���� 0 tempitem tempItemb k��k Z Ullm����l = U`non n  U\pqp m  X\��
�� 
pclsq o  UX���� 0 tempitem tempItemo m  \_��
�� 
longm r  chrsr [  cftut o  cd���� 00 howmanynumbersinputted howManyNumbersInputtedu m  de���� s o      ���� 00 howmanynumbersinputted howManyNumbersInputted��  ��  ��  _ R      ������
�� .ascrerr ****      � ****��  ��  ��  ��  ��  S v��v r  z�wxw m  z}yy �zz  x o      ���� 0 tempitem tempItem��  �� 0 i  O m   !���� P l !){����{ n  !)|}| 1  $(��
�� 
leng} o  !$���� 0 	inputlist 	inputList��  ��  ��  M ~~ l ����������  ��  ��   ��� l ��������  � !  See if they included AM/PM   � ��� 6   S e e   i f   t h e y   i n c l u d e d   A M / P M� ��� Z ��������� I  ��������� (0 isnumberidentifier isNumberIdentifier� ��� m  ���� ���  a� ���� o  ������ 0 datedesired dateDesired��  ��  � r  ����� m  ���� ���  A M� o      ���� 0 inthe inThe��  ��  � ��� Z ��������� I  ��������� (0 isnumberidentifier isNumberIdentifier� ��� m  ���� ���  p� ���� o  ������ 0 datedesired dateDesired��  ��  � r  ����� m  ���� ���  P M� o      ���� 0 inthe inThe��  ��  � ��� l ����������  ��  ��  � ��� l ��������  � R L Get the numbers of the input ��start from the back to get the minutes first   � ��� �   G e t   t h e   n u m b e r s   o f   t h e   i n p u t    � s t a r t   f r o m   t h e   b a c k   t o   g e t   t h e   m i n u t e s   f i r s t� ��� Y  �A������� Q  �<����� k  �3�� ��� l ��������  � K E If the minutes have a leading zero, just combine them with the hours   � ��� �   I f   t h e   m i n u t e s   h a v e   a   l e a d i n g   z e r o ,   j u s t   c o m b i n e   t h e m   w i t h   t h e   h o u r s� ���� Z  �3������ F  ����� l �������� =  ����� o  ������ 0 numlist numList� J  ������  ��  ��  � l �������� C  ����� l �������� n  ����� 4  �����
�� 
cobj� o  ������ 0 i  � o  ������ 0 	inputlist 	inputList��  ��  � m  ���� ���  0��  ��  � k  �	�� ��� r  ���� c  � ��� l �������� b  ����� l �������� n  ����� 4  �����
�� 
cobj� l �������� \  ����� o  ������ 0 i  � m  ������ ��  ��  � o  ������ 0 	inputlist 	inputList��  ��  � l �������� n  ����� 4  �����
�� 
cobj� o  ������ 0 i  � o  ������ 0 	inputlist 	inputList��  ��  ��  ��  � m  ����
�� 
nmbr� l     ������ n      ���  ;  � o   ���� 0 numlist numList��  ��  � ���� r  	��� m  ��
�� boovtrue� o      ���� &0 minuteleadingzero minuteLeadingZero��  ��  � k  3�� ��� l ������  � &   Otherwise, get the numbers only   � ��� @   O t h e r w i s e ,   g e t   t h e   n u m b e r s   o n l y� ��� r  ��� c  ��� l ������ n  ��� 4  ���
�� 
cobj� o  ���� 0 i  � o  ���� 0 	inputlist 	inputList��  ��  � m  ��
�� 
nmbr� o      ���� 0 tempnum tempNum� ���� Z 3������� >  $��� o  "���� 0 tempnum tempNum� m  "#����  � r  '/��� o  '*�� 0 tempnum tempNum� l     ��~�}� n      ���  ;  -.� o  *-�|�| 0 numlist numList�~  �}  ��  ��  ��  ��  � R      �{�z�y
�{ .ascrerr ****      � ****�z  �y  ��  �� 0 i  � l ����x�w� n  ����� 1  ���v
�v 
leng� o  ���u�u 0 	inputlist 	inputList�x  �w  � m  ���t�t � m  ���s�s���    l BB�r�q�p�r  �q  �p    l BB�o�o   I C Reverse it so the order is from biggest to smallest time increment    � �   R e v e r s e   i t   s o   t h e   o r d e r   i s   f r o m   b i g g e s t   t o   s m a l l e s t   t i m e   i n c r e m e n t  r  BM	
	 n  BI 1  EI�n
�n 
rvse o  BE�m�m 0 numlist numList
 o      �l�l 0 numlist numList  l NN�k�j�i�k  �j  �i    Z  N F  N[ l NQ�h�g = NQ o  NO�f�f 0 
monthfound 
monthFound m  OP�e�e  �h  �g   l TW�d�c = TW o  TU�b�b 0 weekdayfound weekdayFound m  UV�a�a  �d  �c   k  ^)  l ^^�` !�`    * $ If the user gave a relative date...   ! �"" H   I f   t h e   u s e r   g a v e   a   r e l a t i v e   d a t e . . . #$# O  ^�%&% k  b�'' ()( r  bn*+* H  bl,, n bk-.- I  ck�_/�^�_ (0 isnumberidentifier isNumberIdentifier/ 010 m  cf22 �33  d1 4�]4  g  fg�]  �^  .  f  bc+ o      �\�\ 0 daysmissing daysMissing) 565 r  o{787 H  oy99 n ox:;: I  px�[<�Z�[ (0 isnumberidentifier isNumberIdentifier< =>= m  ps?? �@@  w> A�YA  g  st�Y  �Z  ;  f  op8 o      �X�X 0 weeksmissing weeksMissing6 B�WB Z |�CD�V�UC =  |�EFE l |�G�T�SG \  |�HIH \  |�JKJ o  |}�R�R 00 howmanynumbersinputted howManyNumbersInputtedK l }�L�Q�PL c  }�MNM l }O�O�NO H  }PP o  }~�M�M 0 daysmissing daysMissing�O  �N  N m  ��L
�L 
long�Q  �P  I l ��Q�K�JQ c  ��RSR l ��T�I�HT H  ��UU o  ���G�G 0 weeksmissing weeksMissing�I  �H  S m  ���F
�F 
long�K  �J  �T  �S  F m  ���E�E  D r  ��VWV m  ���D
�D boovtrueW o      �C�C 0 timemissing timeMissing�V  �U  �W  & o  ^_�B�B 0 datedesired dateDesired$ XYX l ���A�@�?�A  �@  �?  Y Z[Z l ���>\]�>  \    Figure out how many weeks   ] �^^ 4   F i g u r e   o u t   h o w   m a n y   w e e k s[ _`_ Z  ��ab�=ca H  ��dd o  ���<�< 0 weeksmissing weeksMissingb r  ��efe n  ��ghg 4  ���;i
�; 
cobji m  ���:�: h o  ���9�9 0 numlist numListf o      �8�8 0 weeksdeferred weeksDeferred�=  c r  ��jkj m  ���7�7  k o      �6�6 0 weeksdeferred weeksDeferred` lml l ���5�4�3�5  �4  �3  m non l ���2pq�2  p   Figure out how many days   q �rr 2   F i g u r e   o u t   h o w   m a n y   d a y so sts Z  ��uv�1wu H  ��xx o  ���0�0 0 daysmissing daysMissingv r  ��yzy I  ���/{�.�/ 0 howmanydays howManyDays{ |}| o  ���-�- 0 numlist numList} ~�,~ o  ���+�+ 0 weeksmissing weeksMissing�,  �.  z o      �*�* 0 daysdeferred daysDeferred�1  w Z  ����)� E  ����� o  ���(�( 0 datedesired dateDesired� m  ���� ���  T o m o r r o w� k  ���� ��� l ���'���'  � - ' Special case where they put "tomorrow"   � ��� N   S p e c i a l   c a s e   w h e r e   t h e y   p u t   " t o m o r r o w "� ��&� r  ����� m  ���%�% � o      �$�$ 0 daysdeferred daysDeferred�&  �)  � k  ���� ��� l ���#���#  � 1 + If they exclude it entirely or put "Today"   � ��� V   I f   t h e y   e x c l u d e   i t   e n t i r e l y   o r   p u t   " T o d a y "� ��"� r  ����� m  ���!�!  � o      � �  0 daysdeferred daysDeferred�"  t ��� l ������  �  �  � ��� l ������  �   Figure out the time   � ��� (   F i g u r e   o u t   t h e   t i m e� ��� r  ����� I  ������ $0 figureoutthetime figureOutTheTime� ��� o  ���� 0 numlist numList� ��� o  ���� 0 timemissing timeMissing� ��� o  ���� 0 daysmissing daysMissing� ��� o  ���� 0 weeksmissing weeksMissing� ��� o  ���� &0 minuteleadingzero minuteLeadingZero�  �  � o      �� $0 timedeferredtemp timeDeferredTemp� ��� l ������  � 3 - Understand the meaning of the time component   � ��� Z   U n d e r s t a n d   t h e   m e a n i n g   o f   t h e   t i m e   c o m p o n e n t� ��� r  ����� I  ������ &0 understandthetime understandTheTime� ��� o  ���� $0 timedeferredtemp timeDeferredTemp� ��� o  ���� 0 inthe inThe� ��� o  ���� 0 timemissing timeMissing�  �  � o      �� 0 timedeferred timeDeferred� ��� l ���
�	��
  �	  �  � ��� l ������  � G A Creating the time deferred based on minutes and hours calculated   � ��� �   C r e a t i n g   t h e   t i m e   d e f e r r e d   b a s e d   o n   m i n u t e s   a n d   h o u r s   c a l c u l a t e d� ��� Z  �'����� @  ���� o  ��� 0 timedeferred timeDeferred� m  ��  � r  ��� [  ��� [  ��� o  	�� 0 timedeferred timeDeferred� ]  	��� o  	�� 0 daysdeferred daysDeferred� 1  �
� 
days� ]  ��� o  � �  0 weeksdeferred weeksDeferred� 1  ��
�� 
week� o      ���� &0 totaltimedeferred totalTimeDeferred�  � r   '��� o   #���� 0 timedeferred timeDeferred� o      ���� &0 totaltimedeferred totalTimeDeferred� ��� l ((������  � %  end of relative date-only code   � ��� >   e n d   o f   r e l a t i v e   d a t e - o n l y   c o d e� ���� l ((��������  ��  ��  ��   ��� F  ,9��� l ,/������ ?  ,/��� o  ,-���� 0 weekdayfound weekdayFound� m  -.����  ��  ��  � l 25������ = 25��� o  23���� 0 
monthfound 
monthFound� m  34����  ��  ��  � ���� k  <��� ��� Z <O������� A  <E��� n  <C��� 1  ?C��
�� 
leng� o  <?���� 0 numlist numList� m  CD���� � r  HK��� m  HI��
�� boovtrue� o      ���� 0 timemissing timeMissing��  ��  � ��� l PP������  � F @ Same as if the day and the week were missing on a relative date   � ��� �   S a m e   a s   i f   t h e   d a y   a n d   t h e   w e e k   w e r e   m i s s i n g   o n   a   r e l a t i v e   d a t e� ��� r  P`��� I  P\������� $0 figureoutthetime figureOutTheTime� ��� o  QT���� 0 numlist numList� ��� o  TU���� 0 timemissing timeMissing�    m  UV��
�� boovtrue  m  VW��
�� boovtrue �� o  WX���� &0 minuteleadingzero minuteLeadingZero��  ��  � o      ���� $0 timedeferredtemp timeDeferredTemp�  r  ao I  ak��	���� &0 understandthetime understandTheTime	 

 o  be���� $0 timedeferredtemp timeDeferredTemp  o  ef���� 0 inthe inThe �� o  fg���� 0 timemissing timeMissing��  ��   o      ���� 0 timedeferred timeDeferred  r  pz I  pv������ 00 daysfromtodaytoweekday daysFromTodayToWeekday �� o  qr���� 0 weekdayfound weekdayFound��  ��   o      ���� 0 daysdeferred daysDeferred �� Z  {��� @  {� o  {~���� 0 timedeferred timeDeferred m  ~����   r  �� [  �� ]  ��  o  ������ 0 daysdeferred daysDeferred  1  ����
�� 
days o  ������ 0 timedeferred timeDeferred o      ���� &0 totaltimedeferred totalTimeDeferred��   r  ��!"! o  ������ 0 timedeferred timeDeferred" o      ���� &0 totaltimedeferred totalTimeDeferred��  ��   k  �## $%$ l ����&'��  & + % If the user gave an absolute date...   ' �(( J   I f   t h e   u s e r   g a v e   a n   a b s o l u t e   d a t e . . .% )*) Z ��+,����+ A  ��-.- n  ��/0/ 1  ����
�� 
leng0 o  ������ 0 numlist numList. m  ������ , r  ��121 m  ����
�� boovtrue2 o      ���� 0 timemissing timeMissing��  ��  * 343 l ����56��  5 G A Same as if the day were there but week wasn't on a relative date   6 �77 �   S a m e   a s   i f   t h e   d a y   w e r e   t h e r e   b u t   w e e k   w a s n ' t   o n   a   r e l a t i v e   d a t e4 898 r  ��:;: I  ����<���� $0 figureoutthetime figureOutTheTime< =>= o  ������ 0 numlist numList> ?@? o  ������ 0 timemissing timeMissing@ ABA m  ����
�� boovfalsB CDC m  ����
�� boovtrueD E��E o  ������ &0 minuteleadingzero minuteLeadingZero��  ��  ; o      ���� $0 timedeferredtemp timeDeferredTemp9 FGF r  ��HIH I  ����J���� &0 understandthetime understandTheTimeJ KLK o  ������ $0 timedeferredtemp timeDeferredTempL MNM o  ������ 0 inthe inTheN O��O o  ������ 0 timemissing timeMissing��  ��  I o      ���� 0 timedeferred timeDeferredG PQP r  ��RSR I  ����T���� 40 figuringtimetodesiredday figuringTimeToDesiredDayT UVU o  ������ 0 
monthfound 
monthFoundV W��W l ��X����X n  ��YZY 4  ����[
�� 
cobj[ m  ������ Z o  ������ 0 numlist numList��  ��  ��  ��  S o      ���� 60 timefromtodayuntildesired timeFromTodayUntilDesiredQ \��\ Z  �]^��_] @  ��`a` o  ������ 0 timedeferred timeDeferreda m  ������  ^ r  ��bcb [  ��ded o  ������ 60 timefromtodayuntildesired timeFromTodayUntilDesirede o  ������ 0 timedeferred timeDeferredc o      ���� &0 totaltimedeferred totalTimeDeferred��  _ r  �fgf o  ������ 0 timedeferred timeDeferredg o      ���� &0 totaltimedeferred totalTimeDeferred��   hih l ��������  ��  ��  i jkj L  ll o  ���� &0 totaltimedeferred totalTimeDeferredk m��m l 		��������  ��  ��  ��  � non l     ��������  ��  ��  o pqp l     ��������  ��  ��  q rsr i   ? Btut I      ��v���� (0 isnumberidentifier isNumberIdentifierv wxw o      ���� (0 possibleidentifier possibleIdentifierx y��y o      ���� "0 containerstring containerString��  ��  u k     �zz {|{ r     }~} m     ��
�� boovtrue~ o      ���� $0 numberidentifier numberIdentifier| � r    ��� m    ��
�� boovfals� o      ���� 20 identifierisincontainer identifierIsInContainer� ��� r    ��� m    	����  � o      ���� 40 positionoflastidentifier positionOfLastIdentifier� ��� r    ��� n    ��� 2    ��
�� 
cha � o    ���� "0 containerstring containerString� o      �� 0 charlist charList� ��� l   �~�}�|�~  �}  �|  � ��� Y    8��{���z� Z    3���y�x� =    %��� l   #��w�v� n    #��� 4     #�u�
�u 
cobj� o   ! "�t�t 0 i  � o     �s�s 0 charlist charList�w  �v  � o   # $�r�r (0 possibleidentifier possibleIdentifier� k   ( /�� ��� r   ( +��� m   ( )�q
�q boovtrue� o      �p�p 20 identifierisincontainer identifierIsInContainer� ��o� r   , /��� o   , -�n�n 0 i  � o      �m�m 40 positionoflastidentifier positionOfLastIdentifier�o  �y  �x  �{ 0 i  � m    �l�l � l   ��k�j� n    ��� 1    �i
�i 
leng� o    �h�h 0 charlist charList�k  �j  �z  � ��� l  9 9�g�f�e�g  �f  �e  � ��� Z   9 ���d�� G   9 D��� l  9 <��c�b� =  9 <��� o   9 :�a�a 40 positionoflastidentifier positionOfLastIdentifier� m   : ;�`�`  �c  �b  � l  ? B��_�^� =  ? B��� o   ? @�]�] 40 positionoflastidentifier positionOfLastIdentifier� m   @ A�\�\ �_  �^  � r   G J��� m   G H�[
�[ boovfals� o      �Z�Z $0 numberidentifier numberIdentifier�d  � k   M �� ��� r   M U��� n   M S��� 4   N S�Y�
�Y 
cha � l  O R��X�W� \   O R��� o   O P�V�V 40 positionoflastidentifier positionOfLastIdentifier� m   P Q�U�U �X  �W  � o   M N�T�T "0 containerstring containerString� o      �S�S "0 characterbefore characterBefore� ��� Q   V g���R� r   Y ^��� c   Y \��� o   Y Z�Q�Q "0 characterbefore characterBefore� m   Z [�P
�P 
long� o      �O�O "0 characterbefore characterBefore� R      �N�M�L
�N .ascrerr ****      � ****�M  �L  �R  � ��K� Z  h ���J�I� F   h u��� l  h k��H�G� >  h k��� o   h i�F�F "0 characterbefore characterBefore� m   i j�� ���   �H  �G  � l  n s��E�D� >  n s��� n   n q��� m   o q�C
�C 
pcls� o   n o�B�B "0 characterbefore characterBefore� m   q r�A
�A 
long�E  �D  � r   x {��� m   x y�@
�@ boovfals� o      �?�? $0 numberidentifier numberIdentifier�J  �I  �K  � ��>� L   � ��� o   � ��=�= $0 numberidentifier numberIdentifier�>  s ��� l     �<�;�:�<  �;  �:  � ��� l     �9�8�7�9  �8  �7  � ��� i   C F��� I      �6��5�6 0 howmanydays howManyDays� ��� o      �4�4 0 numlist numList� ��3� o      �2�2 0 weeksmissing weeksMissing�3  �5  � k     �� ��� Z     ���1�� H     �� o     �0�0 0 weeksmissing weeksMissing� r    ��� n    	��� 4    	�/�
�/ 
cobj� m    �.�. � o    �-�- 0 numlist numList� o      �,�, 0 daysdeferred daysDeferred�1  � r    ��� n    ��� 4    �+�
�+ 
cobj� m    �*�* � o    �)�) 0 numlist numList� o      �(�( 0 daysdeferred daysDeferred� ��'� L    �� o    �&�& 0 daysdeferred daysDeferred�'  � ��� l     �%�$�#�%  �$  �#  � � � l     �"�!� �"  �!  �      i   G J I      ��� $0 figureoutthetime figureOutTheTime  o      �� 0 numlist numList 	 o      �� 0 timemissing timeMissing	 

 o      �� 0 daysmissing daysMissing  o      �� 0 weeksmissing weeksMissing � o      �� &0 minuteleadingzero minuteLeadingZero�  �   k     <  Z     9� H      o     �� 0 timemissing timeMissing Z    3� o    �� &0 minuteleadingzero minuteLeadingZero r   	  n   	  4   
 �
� 
cobj m    ���� o   	 
�� 0 numlist numList o      �� $0 timedeferredtemp timeDeferredTemp�   k    3   r    !"! m    ## �$$  " 1    �
� 
txdl  %�% r    3&'& c    1()( l   /*��* c    /+,+ l   --��
- n    -./. 7   -�	01
�	 
cobj0 m    ����1 l    ,2��2 [     ,343 [   ! '565 m   ! "�� 6 l  " &7��7 c   " &898 l  " $:��: H   " $;; o   " #� �  0 daysmissing daysMissing�  �  9 m   $ %��
�� 
long�  �  4 l 	 ' +<����< l  ' +=����= c   ' +>?> l  ' )@����@ H   ' )AA o   ' (���� 0 weeksmissing weeksMissing��  ��  ? m   ) *��
�� 
long��  ��  ��  ��  �  �  / o    ���� 0 numlist numList�  �
  , m   - .��
�� 
ctxt�  �  ) m   / 0��
�� 
long' o      ���� $0 timedeferredtemp timeDeferredTemp�  �   r   6 9BCB m   6 7����  C o      ���� $0 timedeferredtemp timeDeferredTemp D��D L   : <EE o   : ;���� $0 timedeferredtemp timeDeferredTemp��   FGF l     ��������  ��  ��  G HIH l     ��������  ��  ��  I JKJ i  K NLML I      ��N���� &0 understandthetime understandTheTimeN OPO o      ���� $0 timedeferredtemp timeDeferredTempP QRQ o      ���� 0 inthe inTheR S��S o      ���� 0 timemissing timeMissing��  ��  M k     �TT UVU Z     �WX��YW o     ���� 0 timemissing timeMissingX r    Z[Z m    ����  [ o      ���� 0 timedeferred timeDeferred��  Y Z   
 �\]^��\ ?   
 _`_ o   
 ���� $0 timedeferredtemp timeDeferredTemp` m    ����	`] k    aa bcb l   ��de��  d 7 1 If the time is greater than the 24 hour clock...   e �ff b   I f   t h e   t i m e   i s   g r e a t e r   t h a n   t h e   2 4   h o u r   c l o c k . . .c ghg I   ��i��
�� .sysodisAaleR        TEXTi m    jj �kk � P l e a s e   t r y   a g a i n :   t h e   t i m e   y o u   e n t e r e d   w a s   n o t   a   v a l i d   t i m e   o f   d a y .��  h lml r    non m    ������o o      ���� 0 timedeferred timeDeferredm p��p l   ��������  ��  ��  ��  ^ qrq =    !sts o    ���� $0 timedeferredtemp timeDeferredTempt m     ����	`r uvu k   $ )ww xyx l  $ $��z{��  z &   If the time is equal to 2400...   { �|| @   I f   t h e   t i m e   i s   e q u a l   t o   2 4 0 0 . . .y }~} r   $ '� 1   $ %��
�� 
days� o      ���� 0 timedeferred timeDeferred~ ���� l  ( (��������  ��  ��  ��  v ��� @   , /��� o   , -���� $0 timedeferredtemp timeDeferredTemp� m   - .���� d� ��� k   2 ��� ��� l  2 2������  � p j if they entered the time as a full hour:minute pair (with or without AM/PM and with or without the colon)   � ��� �   i f   t h e y   e n t e r e d   t h e   t i m e   a s   a   f u l l   h o u r : m i n u t e   p a i r   ( w i t h   o r   w i t h o u t   A M / P M   a n d   w i t h   o r   w i t h o u t   t h e   c o l o n )� ��� r   2 E��� l  2 C������ c   2 C��� l  2 A������ c   2 A��� l  2 ?������ n   2 ?��� 7  5 ?����
�� 
cha � m   9 ;������� m   < >������� l  2 5������ c   2 5��� o   2 3���� $0 timedeferredtemp timeDeferredTemp� m   3 4��
�� 
ctxt��  ��  ��  ��  � m   ? @��
�� 
ctxt��  ��  � m   A B��
�� 
long��  ��  � o      ���� "0 minutesdeferred minutesDeferred� ��� r   F Y��� l  F W������ c   F W��� l  F U������ c   F U��� l  F S������ n   F S��� 7  I S����
�� 
cha � m   M O���� � m   P R������� l  F I������ c   F I��� o   F G���� $0 timedeferredtemp timeDeferredTemp� m   G H��
�� 
ctxt��  ��  ��  ��  � m   S T��
�� 
ctxt��  ��  � m   U V��
�� 
long��  ��  � o      ���� 0 hoursdeferred hoursDeferred� ��� l  Z Z������  � Z T Figuring out the minutes and hours in the time given (minutes are last two numbers)   � ��� �   F i g u r i n g   o u t   t h e   m i n u t e s   a n d   h o u r s   i n   t h e   t i m e   g i v e n   ( m i n u t e s   a r e   l a s t   t w o   n u m b e r s )� ��� l  Z Z��������  ��  ��  � ��� Z   Z ������ =   Z ]��� o   Z [���� 0 inthe inThe� m   [ \�� ���  P M� k   ` k�� ��� l  ` `������  � 3 - For any number specifically designated as PM   � ��� Z   F o r   a n y   n u m b e r   s p e c i f i c a l l y   d e s i g n a t e d   a s   P M� ���� r   ` k��� l  ` i������ [   ` i��� ]   ` e��� l  ` c������ [   ` c��� o   ` a���� 0 hoursdeferred hoursDeferred� m   a b���� ��  ��  � 1   c d��
�� 
hour� ]   e h��� o   e f���� "0 minutesdeferred minutesDeferred� 1   f g��
�� 
min ��  ��  � o      ���� 0 timedeferred timeDeferred��  � ��� F   n y��� =   n q��� o   n o���� 0 hoursdeferred hoursDeferred� m   o p���� � =   t w��� o   t u���� 0 inthe inThe� m   u v�� ���  A M� ���� k   | ��� ��� l  | |������  �   For 12:00AM exactly   � ��� (   F o r   1 2 : 0 0 A M   e x a c t l y� ���� r   | ���� ]   | ��� o   | }�� "0 minutesdeferred minutesDeferred� 1   } ~�
� 
min � o      �� 0 timedeferred timeDeferred��  ��  � k   � ��� ��� l  � �����  � \ V For times in the AM (implicit or explicit) and explicit times in the PM (i.e., 16:00)   � ��� �   F o r   t i m e s   i n   t h e   A M   ( i m p l i c i t   o r   e x p l i c i t )   a n d   e x p l i c i t   t i m e s   i n   t h e   P M   ( i . e . ,   1 6 : 0 0 )� ��� r   � ���� l  � ����� [   � ���� ]   � ���� o   � ��� 0 hoursdeferred hoursDeferred� 1   � ��
� 
hour� ]   � ���� o   � ��� "0 minutesdeferred minutesDeferred� 1   � ��
� 
min �  �  � o      �� 0 timedeferred timeDeferred�  � ��� l  � �����  �  �  �  � ��� ?   � �� � o   � ��� $0 timedeferredtemp timeDeferredTemp  m   � ��~�~ �  k   � �  l  � ��}�}   ; 5 If they entered the time as a single number above 24    � j   I f   t h e y   e n t e r e d   t h e   t i m e   a s   a   s i n g l e   n u m b e r   a b o v e   2 4 	
	 I  � ��|�{
�| .sysodisAaleR        TEXT m   � � � � P l e a s e   t r y   a g a i n :   t h e   t i m e   y o u   e n t e r e d   w a s   n o t   a   v a l i d   t i m e   o f   d a y .�{  
  r   � � m   � ��z�z�� o      �y�y 0 timedeferred timeDeferred �x l  � ��w�v�u�w  �v  �u  �x    B   � � o   � ��t�t $0 timedeferredtemp timeDeferredTemp m   � ��s�s  �r k   � �  l  � ��q�q   J D If the entered the time as a single number (with or without AM/PM)	    � �   I f   t h e   e n t e r e d   t h e   t i m e   a s   a   s i n g l e   n u m b e r   ( w i t h   o r   w i t h o u t   A M / P M ) 	 �p Z   � � !" =   � �#$# o   � ��o�o $0 timedeferredtemp timeDeferredTemp$ m   � ��n�n   k   � �%% &'& l  � ��m()�m  ( E ? If they entered 24 hours exactly (treat as a full extra delay)   ) �** ~   I f   t h e y   e n t e r e d   2 4   h o u r s   e x a c t l y   ( t r e a t   a s   a   f u l l   e x t r a   d e l a y )' +�l+ r   � �,-, 1   � ��k
�k 
days- o      �j�j 0 timedeferred timeDeferred�l  ! ./. F   � �010 l  � �2�i�h2 =   � �343 o   � ��g�g $0 timedeferredtemp timeDeferredTemp4 m   � ��f�f �i  �h  1 l  � �5�e�d5 >   � �676 o   � ��c�c 0 inthe inThe7 m   � �88 �99  A M�e  �d  / :;: k   � �<< =>= l  � ��b?@�b  ? . ( If they entered "12" (treat it as 12PM)   @ �AA P   I f   t h e y   e n t e r e d   " 1 2 "   ( t r e a t   i t   a s   1 2 P M )> B�aB r   � �CDC ]   � �EFE m   � ��`�` F 1   � ��_
�_ 
hourD o      �^�^ 0 timedeferred timeDeferred�a  ; GHG G   � �IJI l  � �K�]�\K @   � �LML o   � ��[�[ $0 timedeferredtemp timeDeferredTempM m   � ��Z�Z �]  �\  J l  � �N�Y�XN >   � �OPO o   � ��W�W 0 inthe inTheP m   � �QQ �RR  P M�Y  �X  H S�VS k   � �TT UVU l  � ��UWX�U  W G A For implicit and explicit AM entries and for implicit PM entries   X �YY �   F o r   i m p l i c i t   a n d   e x p l i c i t   A M   e n t r i e s   a n d   f o r   i m p l i c i t   P M   e n t r i e sV Z�TZ r   � �[\[ ]   � �]^] o   � ��S�S $0 timedeferredtemp timeDeferredTemp^ 1   � ��R
�R 
hour\ o      �Q�Q 0 timedeferred timeDeferred�T  �V  " k   � �__ `a` l  � ��Pbc�P  b   For explicit PM entries   c �dd 0   F o r   e x p l i c i t   P M   e n t r i e sa e�Oe r   � �fgf ]   � �hih l  � �j�N�Mj [   � �klk o   � ��L�L $0 timedeferredtemp timeDeferredTempl m   � ��K�K �N  �M  i 1   � ��J
�J 
hourg o      �I�I 0 timedeferred timeDeferred�O  �p  �r  ��  V m�Hm L   � �nn o   � ��G�G 0 timedeferred timeDeferred�H  K opo l     �F�E�D�F  �E  �D  p qrq l     �C�B�A�C  �B  �A  r sts i  O Ruvu I      �@w�?�@ 40 figuringtimetodesiredday figuringTimeToDesiredDayw xyx o      �>�> 0 monthdesired monthDesiredy z�=z o      �<�< 0 
daydesired 
dayDesired�=  �?  v k     ;{{ |}| r     ~~ l    ��;�:� I    �9�8�7
�9 .misccurdldt    ��� null�8  �7  �;  �:   o      �6�6 0 
todaysdate 
todaysDate} ��� r    ��� m    	�5�5  � n      ��� 1   
 �4
�4 
time� o   	 
�3�3 0 
todaysdate 
todaysDate� ��� l   �2���2  � %  Creating an intial date object   � ��� >   C r e a t i n g   a n   i n t i a l   d a t e   o b j e c t� ��� s    ��� o    �1�1 0 
todaysdate 
todaysDate� o      �0�0 $0 exactdesireddate exactDesiredDate� ��� r    ��� o    �/�/ 0 
daydesired 
dayDesired� l     ��.�-� n      ��� 1    �,
�, 
day � o    �+�+ $0 exactdesireddate exactDesiredDate�.  �-  � ��� r    ��� o    �*�* 0 monthdesired monthDesired� l     ��)�(� n      ��� m    �'
�' 
mnth� o    �&�& $0 exactdesireddate exactDesiredDate�)  �(  � ��� Z    6���%�$� A    &��� o     �#�# $0 exactdesireddate exactDesiredDate� l    %��"�!� I    %� ��
�  .misccurdldt    ��� null�  �  �"  �!  � r   ) 2��� l  ) .���� [   ) .��� l  ) ,���� n   ) ,��� 1   * ,�
� 
year� o   ) *�� 0 
todaysdate 
todaysDate�  �  � m   , -�� �  �  � l     ���� n      ��� 1   / 1�
� 
year� o   . /�� $0 exactdesireddate exactDesiredDate�  �  �%  �$  � ��� L   7 ;�� l  7 :���� \   7 :��� o   7 8�� $0 exactdesireddate exactDesiredDate� o   8 9�� 0 
todaysdate 
todaysDate�  �  �  t ��� l     ����  �  �  � ��� l     �
�	��
  �	  �  � ��� i   S V��� I      ���� 00 daysfromtodaytoweekday daysFromTodayToWeekday� ��� o      ��  0 weekdaydesired weekdayDesired�  �  � k     0�� ��� r     ��� c     	��� l    ���� n     ��� m    � 
�  
wkdy� l    ������ I    ������
�� .misccurdldt    ��� null��  ��  ��  ��  �  �  � m    ��
�� 
long� o      ����  0 currentweekday currentWeekday� ��� Z    -����� =    ��� o    ����  0 currentweekday currentWeekday� o    ����  0 weekdaydesired weekdayDesired� r    ��� m    ����  � o      ���� 0 daysdeferred daysDeferred� ��� A    ��� o    ����  0 currentweekday currentWeekday� o    ����  0 weekdaydesired weekdayDesired� ���� r    #��� \    !��� o    ����  0 weekdaydesired weekdayDesired� o     ����  0 currentweekday currentWeekday� o      ���� 0 daysdeferred daysDeferred��  � r   & -��� \   & +��� [   & )��� m   & '���� � o   ' (����  0 weekdaydesired weekdayDesired� o   ) *����  0 currentweekday currentWeekday� o      ���� 0 daysdeferred daysDeferred� ���� L   . 0�� o   . /���� 0 daysdeferred daysDeferred��  �       ��� ������ ���������������������  � ��������������������������������������������������  0 variablesymbol variableSymbol�� 0 firstrun firstRun�� .0 specialtemplatefolder specialTemplateFolder�� "0 shownewinstance showNewInstance�� ,0 defaultfolderpointer defaultFolderPointer�� (0 selectionpositions selectionPositions�� $0 populatetemplate populateTemplate�� $0 replacevariables replaceVariables�� (0 eliminatevariables eliminateVariables�� &0 workingthecontext workingTheContext�� $0 findthevariables findTheVariables�� *0 findthereplacements findTheReplacements�� &0 cleanexcessbreaks cleanExcessBreaks�� .0 checkforothertemplate checkForOtherTemplate�� 20 adjustoldtemplatesyntax adjustOldTemplateSyntax�� 80 checkingfordateinformation checkingForDateInformation�� 0 englishtime englishTime�� (0 isnumberidentifier isNumberIdentifier�� 0 howmanydays howManyDays�� $0 figureoutthetime figureOutTheTime�� &0 understandthetime understandTheTime�� 40 figuringtimetodesiredday figuringTimeToDesiredDay�� 00 daysfromtodaytoweekday daysFromTodayToWeekday
�� .aevtoappnull  �   � ****
�� boovtrue
�� 
null
�� boovtrue� ������������� (0 selectionpositions selectionPositions�� ����� �  �������� 0 
selectlist 
selectList�� 0 originallist originalList�� (0 multipleselections multipleSelections��  � ��������������� 0 
selectlist 
selectList�� 0 originallist originalList�� (0 multipleselections multipleSelections�� 0 choicesfound choicesFound�� ,0 positionofselections positionOfSelections� 0 j  � 0 k  � 0 achoicefound aChoiceFound� ����
� 
leng
� 
bool
� 
cobj
� 
null�� Ѣ rjE�OjvE�OkE�O _h���,
 	���, �&kE�OfE�O 8h���,
 ��&��/��/ ��6FOeE�O�kE�Y hO�kE�[OY��O�kE�[OY��Y [kE�O�E�O Ph���,
 ���&kE�O /h���,
 ���&��/��/ �E�Y hO�kE�[OY��O�kE�[OY��O�� �U������ $0 populatetemplate populateTemplate� ��� �  ���� 0 
theproject 
theProject� $0 cleanedvariables cleanedVariables� "0 thereplacements theReplacements�  � ��������� 0 
theproject 
theProject� $0 cleanedvariables cleanedVariables� "0 thereplacements theReplacements� .0 delimcleanedvariables delimCleanedVariables� 0 i  � 0 thefullnote theFullNote� 0 
thenewnote 
theNewNote� (0 possibledatechange possibleDateChange� �������������������r�
� 
leng
� 
cobj
� 
FCDo
� 
pnam� $0 replacevariables replaceVariables
� 
FCno� (0 eliminatevariables eliminateVariables� 80 checkingfordateinformation checkingForDateInformation
� 
msng
� 
FCDs
� 
FCDd� &0 cleanexcessbreaks cleanExcessBreaks
� 
FCft
� .corecnte****       ****
� 
FCct� &0 workingthecontext workingTheContext��jvE�O k��,Ekh b   ��/%�6F[OY��O��*�,���)*�,��m+ *�,FO*�,E�O)�k+ E�O)���m+ *�,FO)*k+ E�O�� *��l/�  ��k/*�,FY 
��k/*�,FO��m/*�,FY hO)*k+ E�O�� *��l/�  ��k/*�,FY 
��k/*�,FO��m/*�,FY hO)*�,k+ *�,FO �k*�-j kh *�/ �)*�,��m+ *�,FO)*�,��m+ *�,FO*a ,� )*a ,��m+ *a ,FY hO)*k+ E�O�� ,��l/a   ��k/*�,FY 
��k/*�,FO��m/*�,FY hO)*k+ E�O�� ,��l/a   ��k/*�,FY 
��k/*�,FO��m/*�,FY hO)*�,k+ *�,FU[OY�1UUU� �������� $0 replacevariables replaceVariables� � �    ���� 0 thetext theText� 0 thevariables theVariables� "0 thereplacements theReplacements�  � ����� 0 thetext theText� 0 thevariables theVariables� "0 thereplacements theReplacements� 0 i  � �����
� 
leng
� 
cobj
� 
txdl
� 
citm
� 
TEXT� : 5k��,Ekh ��/)�,FO��-E�O��/)�,FO��&E�Ojv)�,F[OY��O�� ����� (0 eliminatevariables eliminateVariables� ��   �� 0 thenote theNote�   ����~� 0 thenote theNote� 0 i  � $0 variableposition variablePosition�~ 0 
returnnote 
returnNote �}�|$�{�z�y�x�
�} 
cpar
�| .corecnte****       ****
�{ 
ret 
�z 
txdl�y��
�x 
ctxt� ���-j k  �Y � *��-j kih ��/b    
�E�OY h[OY��O�kv)�,FO���-j   �[�\[Zk\Z�2�&E�Y 9�k  �[�\[Zl\Zi2�&E�Y !�[�\[Zk\Z�k2�[�\[Z�k\Zi2%�&E�O�)�,FO�� �w��v�u�t�w &0 workingthecontext workingTheContext�v �s�s   �r�q�p�r 0 
thecontext 
theContext�q 0 thevariables theVariables�p "0 thereplacements theReplacements�u   �o�n�m�l�k�j�i�h�g�f�e�o 0 
thecontext 
theContext�n 0 thevariables theVariables�m "0 thereplacements theReplacements�l 0 i  �k 0 variablefound variableFound�j (0 desiredcontextname desiredContextName�i $0 contextsinfolder contextsInFolder�h "0 positionoffound positionOfFound�g 20 namesofcontextsinfolder namesOfContextsInFolder�f 0 thecontainer theContainer�e 0 
newcontext 
newContext ?�d�c�b�a�`�_�^�]�\�[�Z�Y�X�W
�d 
msng
�c 
leng
�b 
bool
�a 
pnam
�` 
cobj�_ $0 replacevariables replaceVariables
�^ 
ctnr
�] 
FCct
�\ 
null
�[ 
kocl
�Z 
insh
�Y 
prdt�X 
�W .corecrel****      � null�t �� ɠ�  hY �kE�OfE�O -h���,	 ��&��,��/ eE�Y hO�kE�[OY��O� �Y })��,��m+ E�O��,�-E�O�E�OjvE�O +k��,Ekh ��/�,�6FO��/�  �E�Y h[OY��O�� ��/EY #��,E�O� *���*�-6��l� E�UO�U� �VG�U�T�S�V $0 findthevariables findTheVariables�U �R	�R 	  �Q�Q 0 
theproject 
theProject�T   �P�O�N�M�L�K�J�P 0 
theproject 
theProject�O 0 thefullnote theFullNote�N 0 thenote theNote�M 0 i  �L $0 cleanedvariables cleanedVariables�K 0 thevariables theVariables�J 0 thevar theVar ��I�H�G�F�E�D��C�B�A�@�
�I 
FCDo
�H 
FCno
�G 
msng
�F 
null
�E 
cpar
�D .corecnte****       ****
�C 
txdl
�B 
citm
�A 
leng
�@ 
cobj�S �� �*�, ���,E�O��  jvY hO�E�O -��-j kih ��/b    ��/E�OY h[OY��O��  jvY hOjvE�O�b   %b   lv)�,FO��-E�Ojv)�,FO %k��,Ekh ��/� ��/�6FY h[OY��OPUUO�� �?��>�=
�<�? *0 findthereplacements findTheReplacements�> �;�;   �:�: 0 thevariables theVariables�=  
 �9�8�7�6�5�4�3�9 0 thevariables theVariables�8 "0 thereplacements theReplacements�7 0 thetitle theTitle�6 0 i  �5 0 thetext theText�4 0 	errortext 	errorText�3 0 errornumber errorNumber 	�2��1��0�/��.	�-�,�+�*
�2 
FCDo
�1 
leng
�0 
quot
�/ 
cobj
�. 
dtxt
�- .sysodlogaskr        TEXT
�, 
ttxt�+ 0 	errortext 	errorText �)�(�'
�) 
errn�( 0 errornumber errorNumber�'  �*���< ]� V*�, OjvE�O�E�O Ck��,Ekh ��%��/%�%�%E�O ���l 
�,�6FW X  ��  fY h[OY��UUO�� �&	�%�$�#�& &0 cleanexcessbreaks cleanExcessBreaks�% �"�"   �!�! 0 thetext theText�$   � ����  0 thetext theText� 0 i  � 0 textends textEnds� 0 
thenewtext 
theNewText 
�	/	2��	L���	l
� 
msng
� 
cpar
� .corecnte****       ****
� 
ret 
� 
txdl
� 
ctxt�# v��  �Y hO��  �Y hO��-j k  �Y hO &��-j kih ��/� 
�E�OY h[OY��O�kv*�,FO�[�\[Zk\Z�2�&E�O�*�,FO�� �	w���� .0 checkforothertemplate checkForOtherTemplate�  �   ���������
�	�� 0 thecount theCount� (0 templatefolderlist templateFolderList� 00 templatefoldernamelist templateFolderNameList� 0 	thefolder 	theFolder� 0 nextlistitem nextListItem� 00 selectedtemplatefolder selectedTemplateFolder� 00 templatefolderposition templateFolderPosition� 20 existingtemplatefolders existingTemplateFolders�
 0 i  �	 *0 oldtemplateprojects oldTemplateProjects� 40 possibletemplateprojects possibleTemplateProjects "
u���	��	����	�� ����	���	���	���	�����������
'����������
g
� 
FCDo
� 
FCff  
� 
pnam
� .corecnte****       ****
� 
FCHi
� 
kocl
� 
cobj
�  
ctnr
�� 
pcls
�� 
FCAr
�� 
appr
�� 
prmp
�� 
okbt
�� 
mlsl�� 
�� .gtqpchltns    @   @ ns  �� (0 selectionpositions selectionPositions
�� 
leng
�� 
FCfx
�� 
FCPs
�� FCPsFCPD
�� FCPsFCPd
�� 
FCno�{�t*�,m*�-�[�,\Z�@1j E�O*�-�[[�,\Z�@\[�,\Zf8A1j j  �*�-�[�,\Zf81E�OjvE�O 6�[��l kh �E�O��,�,�  �E�Y hO���,%E�O��6F[OY��O�a a a a a a a ea  E�O�f  hY hO)��em+ E�OjvE�O k�a ,Ekh ��/�6F[OY��Y *�-�[[�,\Za @\[�,\Zf8A1E�OjvE�O Bk�a ,Ekh *a -�[[[�,\Z��/8\[a ,\Za 9A\[a ,\Za 9A1E�[OY��O -k�a ,Ekh ��/a  ,a ! ��/�6FY h[OY��UUO�� ��
�������� 20 adjustoldtemplatesyntax adjustOldTemplateSyntax�� ����   ���� *0 oldtemplateprojects oldTemplateProjects��   ���������� *0 oldtemplateprojects oldTemplateProjects�� 0 i  �� 0 tempname tempName�� 0 tempnote tempNote k������
�����������
�
�����
�0Fg
�� 
FCDo
�� 
leng
�� 
cobj
�� 
txdl
�� 
pnam
�� 
citm
�� 
FCno
�� 
TEXT
�� 
FCft
�� .corecnte****       ****���*�, � �k��,Ekh ��/ ��)�,FO*�,E�O��-E�O*�,E�O��-E�Ob   )�,FO��&E�O��&E�O�)�,FO��-E�O��-E�O�)�,FO��&*�,FO��&*�,FO yk*�-j kh *�/ _�)�,FO*�,E�O��-E�O*�,E�O��-E�Ob   )�,FO��&E�O��&E�O�)�,FO��-E�O��-E�Oa )�,FO��&*�,FO��&*�,FU[OY��U[OY�Oa )�,FUU� ��s�������� 80 checkingfordateinformation checkingForDateInformation�� ����   ���� 0 theitem theItem��   ������������������������������������������ 0 theitem theItem�� 0 thenote theNote�� "0 theoriginalnote theOriginalNote�� 0 
dueorstart 
dueOrStart�� 0 
askfordate 
askForDate�� &0 relativetoproject relativeToProject�� &0 thenoteparagraphs theNoteParagraphs�� 0 i  �� 0 classofitem classOfItem�� 0 displaytext displayText�� 0 	inputdate 	inputDate�� 0 	errortext 	errorText�� 0 errornumber errorNumber�� (0 possibledelimiters possibleDelimiters�� 0 tempdate tempDate�� "0 secondsdeferred secondsDeferred�� 0 desireddate desiredDate�� 0 relativedate relativeDate�� 0 numparagraphs numParagraphs�� 0 datespot dateSpot H������������������������ "$��)�7����IMQUY]aeil���~�������� %��;@_d�������
�� 
FCDo
�� 
FCdw
�� 
FCcn
� 
FCno
� 
null
� 
msng
� 
cpar
� 
leng
� 
cobj
� 
bool
� 
pcls
� 
TEXT
� 
quot
� 
pnam
� 
dtxt
� .sysodlogaskr        TEXT
� 
ttxt� 0 	errortext 	errorText ���
� 
errn� 0 errornumber errorNumber�  ���� 

� 
txdl
� 
citm� 0 englishtime englishTime
� .misccurdldt    ��� null
� 
time
� 
FCpr
� 
FCPr
� 
FCDd
� 
FCDs
� 
givu
� .sysodisAaleR        TEXT
� 
ret 
� .corecnte****       ****��������*�,�*�k/�*�,���,E�O�EQ�O�E�OfE�OfE�O�� �E�Y �� �E�Y hO�� eE�Y hO�� eE�Y hO��  �Y ��-E�O 7k��,Ekh ��/a 
 ��/a a & ��/E�OY h[OY��O� _�a ,a &E�Oa �%a %�%a %_ %�a ,%_ %a %E�O �a a l a ,E�W X   �a !  �Y hY Ia "a #a $a %a &a 'a (a )a *a +a ,vE�O�)a -,FO�a .-EQ�Oa /)a -,FO�a &E�O)�k+ 0E�O�j �Y hO� "*j 1E^ Oj] a 2,FO] �E^ Y }�a ,a 3  �Y hO�a 4  +�a 5,a 6,E^ O] �  �Y hO] �E^ Y 9�a 5,a 7,E^ O] �  *j 1E^ Oj] a 2,FY hO] �E^ O�a ,a 3 ȣa 8 	 �a 5,a 6,�a & f] *j 1 $a 9_ %�a ,%_ %a :%a ;a ,l <Y 5] �a 5,a 6, $a =_ %�a ,%_ %a >%a ;a ,l <Y hY G�a 5,a 6,� 8] �a 5,a 6, $a ?_ %�a ,%_ %a @%a ;a ,l <Y hY hY hO��-�,E^ O 5k] kh ���/a A
 ���/a Ba & �E^ OY h[OY��O_ Ckv)a -,FO] k  *��-j Dk  
a EE�Y �[�\[Zl\Zi2a &E�Y G] ]   �[�\[Zk\Za F2a &E�Y '�[�\[Zk\Z] k2�[�\[Z] k\Zi2%a &E�Oa G)a -,FO] ��mvUUUU� ������ 0 englishtime englishTime� ��   �� 0 datedesired dateDesired�   ��������������������������~�}� 0 datedesired dateDesired� 0 
monthfound 
monthFound� 0 weekdayfound weekdayFound� &0 minuteleadingzero minuteLeadingZero� 0 timemissing timeMissing� 0 daysmissing daysMissing� 0 weeksmissing weeksMissing�  0 timedelimiters timeDelimiters� 0 daydelimiters dayDelimiters�  0 weekdelimiters weekDelimiters� "0 monthdelimiters monthDelimiters� &0 weekdaydelimiters weekdayDelimiters� <0 specialrelativedaydelimiters specialRelativeDayDelimiters� "0 otherdelimiters otherDelimiters� 0 inthe inThe� 00 howmanynumbersinputted howManyNumbersInputted� 0 numlist numList� 0 i  � 0 	inputlist 	inputList� 0 tempitem tempItem� 0 tempnum tempNum� 0 weeksdeferred weeksDeferred� 0 daysdeferred daysDeferred� $0 timedeferredtemp timeDeferredTemp� 0 timedeferred timeDeferred�~ &0 totaltimedeferred totalTimeDeferred�} 60 timefromtodayuntildesired timeFromTodayUntilDesired G159=@�|IMPY]`imquy}�������{��������z���������y�x�w�vC\�u�t�s�ry��q�����p�o�n2?�m��l�k�j�i�h�g�| �{ �z 
�y 
leng
�x 
cobj
�w 
txdl
�v 
citm
�u 
long
�t 
pcls�s  �r  �q (0 isnumberidentifier isNumberIdentifier
�p 
bool
�o 
nmbr
�n 
rvse�m 0 howmanydays howManyDays�l $0 figureoutthetime figureOutTheTime�k &0 understandthetime understandTheTime
�j 
days
�i 
week�h 00 daysfromtodaytoweekday daysFromTodayToWeekday�g 40 figuringtimetodesiredday figuringTimeToDesiredDay�jE�OjE�OfE�OfE�OfE�OfE�O������vE�O���mvE�O���mvE�O����a a a a a a a a a vE�Oa a a a a a a a  vE�Oa !a "lvE�Oa #a $a %a &a '�vE�Oa (E�OjE�OjvE^ O Rk�a ),Ekh ��a *] / ] E�OY hO] �a ), ��a *] / 
] E�Y hY h[OY��O��%�%�%�%�%*a +,FO�a ,-E^ Oa -kv*a +,FO hk] a ),Ekh ] a *] /a . ; /] a *] /a /&E^ O] a 0,a /  
�kE�Y hW X 1 2hY hOa 3E^ [OY��O*a 4�l+ 5 
a 6E�Y hO*a 7�l+ 5 
a 8E�Y hO �] a ),Ekih  q] jv 	 ] a *] /a 9a :& )] a *] k/] a *] /%a ;&] 6FOeE�Y )] a *] /a ;&E^ O] j ] ] 6FY hW X 1 2h[OY��O] a <,E^ O�j 	 	�j a :& Р 7)a =*l+ 5E�O)a >*l+ 5E�O��a /&�a /&j  eE�Y hUO� ] a *k/E^ Y jE^ O� *] �l+ ?E^ Y �a @ 
kE^ Y jE^ O*] �����+ AE^ O*] ��m+ BE^ O] j ] ] _ C ] _ D E^ Y 	] E^ OPY ٢j	 	�j a :& e] a ),k eE�Y hO*] �ee��+ AE^ O*] ��m+ BE^ O*�k+ EE^ O] j ] _ C ] E^ Y 	] E^ Y f] a ),l eE�Y hO*] �fe��+ AE^ O*] ��m+ BE^ O*�] a *k/l+ FE^ O] j ] ] E^ Y 	] E^ O] OP� �fu�e�d�c�f (0 isnumberidentifier isNumberIdentifier�e �b �b    �a�`�a (0 possibleidentifier possibleIdentifier�` "0 containerstring containerString�d   �_�^�]�\�[�Z�Y�X�_ (0 possibleidentifier possibleIdentifier�^ "0 containerstring containerString�] $0 numberidentifier numberIdentifier�\ 20 identifierisincontainer identifierIsInContainer�[ 40 positionoflastidentifier positionOfLastIdentifier�Z 0 charlist charList�Y 0 i  �X "0 characterbefore characterBefore 	�W�V�U�T�S�R�Q��P
�W 
cha 
�V 
leng
�U 
cobj
�T 
bool
�S 
long�R  �Q  
�P 
pcls�c �eE�OfE�OjE�O��-E�O %k��,Ekh ��/�  eE�O�E�Y h[OY��O�j 
 �k �& fE�Y 4��k/E�O 
��&E�W X  hO��	 	��,��& fE�Y hO�� �O��N�M!"�L�O 0 howmanydays howManyDays�N �K#�K #  �J�I�J 0 numlist numList�I 0 weeksmissing weeksMissing�M  ! �H�G�F�H 0 numlist numList�G 0 weeksmissing weeksMissing�F 0 daysdeferred daysDeferred" �E
�E 
cobj�L � ��l/E�Y ��k/E�O�� �D�C�B$%�A�D $0 figureoutthetime figureOutTheTime�C �@&�@ &  �?�>�=�<�;�? 0 numlist numList�> 0 timemissing timeMissing�= 0 daysmissing daysMissing�< 0 weeksmissing weeksMissing�; &0 minuteleadingzero minuteLeadingZero�B  $ �:�9�8�7�6�5�: 0 numlist numList�9 0 timemissing timeMissing�8 0 daysmissing daysMissing�7 0 weeksmissing weeksMissing�6 &0 minuteleadingzero minuteLeadingZero�5 $0 timedeferredtemp timeDeferredTemp% �4#�3�2�1
�4 
cobj
�3 
txdl
�2 
long
�1 
ctxt�A =� 3� ��i/E�Y #�*�,FO�[�\[Zi\Zk��&��&2�&�&E�Y jE�O�� �0M�/�.'(�-�0 &0 understandthetime understandTheTime�/ �,)�, )  �+�*�)�+ $0 timedeferredtemp timeDeferredTemp�* 0 inthe inThe�) 0 timemissing timeMissing�.  ' �(�'�&�%�$�#�( $0 timedeferredtemp timeDeferredTemp�' 0 inthe inThe�& 0 timemissing timeMissing�% 0 timedeferred timeDeferred�$ "0 minutesdeferred minutesDeferred�# 0 hoursdeferred hoursDeferred( �"j�!� �������������8Q�"	`
�! .sysodisAaleR        TEXT
�  
days� d
� 
ctxt
� 
cha ���
� 
long���� 
� 
hour
� 
min 
� 
bool� �- �� jE�Y �� �j OiE�OPY ߠ�  
�E�OPY Ѡ� b��&[�\[Z�\Zi2�&�&E�O��&[�\[Zk\Z�2�&�&E�O��  ��� �� E�Y !�� 	 �� �& 
�� E�Y �� �� E�OPY k�a  a j OiE�OPY S�a  J�a   �E�Y 9�� 	 	�a �& 
�� E�Y !��
 	�a �& 
�� E�Y 	��� E�Y hO�� �v��*+�� 40 figuringtimetodesiredday figuringTimeToDesiredDay� �,� ,  ��� 0 monthdesired monthDesired� 0 
daydesired 
dayDesired�  * ����
� 0 monthdesired monthDesired� 0 
daydesired 
dayDesired� 0 
todaysdate 
todaysDate�
 $0 exactdesireddate exactDesiredDate+ �	����
�	 .misccurdldt    ��� null
� 
time
� 
day 
� 
mnth
� 
year� <*j  E�Oj��,FO�EQ�O���,FO���,FO�*j   ��,k��,FY hO��� ����-.�� 00 daysfromtodaytoweekday daysFromTodayToWeekday� � /�  /  ����  0 weekdaydesired weekdayDesired�  - ��������  0 weekdaydesired weekdayDesired��  0 currentweekday currentWeekday�� 0 daysdeferred daysDeferred. ��������
�� .misccurdldt    ��� null
�� 
wkdy
�� 
long�� � 1*j  �,�&E�O��  jE�Y �� 
��E�Y 	��E�O�� ��0����12��
�� .aevtoappnull  �   � ****0 k    33  !����  ��  ��  1 ������������ 0 	errortext 	errorText�� 0 errornumber errorNumber�� 0 	thefolder 	theFolder�� 0 
theproject 
theProject�� 0 i  2 ���������� F�� M P���������� X�� l�� o����4�� � � ��� ����� ����� ����������� ��������� ���������������������Q������������������������������������X��f������������������2<������nux���������������H�mtw
�� 
FCDo�� .0 checkforothertemplate checkForOtherTemplate�� :0 othertemplatescriptprojects otherTemplateScriptProjects
�� 
leng
�� 
btns
�� 
dflt�� 
�� .sysodlogaskr        TEXT
�� 
bhit�� (0 changeoldtemplates changeOldTemplates�� 20 adjustoldtemplatesyntax adjustOldTemplateSyntax
�� 
dtxt
�� 
ttxt�� 0 	errortext 	errorText4 ���
� 
errn� 0 errornumber errorNumber�  ������ $0 instancequestion instanceQuestion
�� 
FCff
�� 
pnam
�� .corecnte****       ****�� 0 thecount theCount
�� 
FCHi�� (0 templatefolderlist templateFolderList�� 00 templatefoldernamelist templateFolderNameList
�� 
kocl
�� 
cobj�� 0 nextlistitem nextListItem
�� 
ctnr
�� 
pcls
�� 
FCAr
�� 
appr
�� 
prmp
�� 
okbt�� 
�� .gtqpchltns    @   @ ns  �� 00 selectedtemplatefolder selectedTemplateFolder�� (0 selectionpositions selectionPositions�� 00 templatefolderposition templateFolderPosition
�� 
null
�� 
FCfx
�� 
FCPs
�� FCPsFCPD
�� FCPsFCPd�� 0 projectlist projectList�� "0 projectnamelist projectNameList
�� .sysodisAaleR        TEXT�� "0 chooselisttitle chooseListTitle�  0 chooselisttext chooseListText� 0 chooselistok chooseListOK� "0 selectedproject selectedProject� "0 projectposition projectPosition� 20 selectedprojecttemplate selectedProjectTemplate
� 
FCHe� 0 
folderlist 
folderList�  0 foldernamelist folderNameList� (0 defaultfolderfound defaultFolderFound�  0 folderposition folderPosition
� 
FCno���� "0 parawithpointer paraWithPointer
� 
cpar� 0 folderpointer folderPointer
� 
txdl
� 
citm
� 
TEXT� &0 folderpointername folderPointerName� 00 selectedfoldertemplate selectedFolderTemplate� $0 findthevariables findTheVariables� 0 thevariables theVariables� 0 justduplicate justDuplicate
� 
quot�  0 selectedfolder selectedFolder
� 
insh
� 
FCpr
� .coreclon****      � ****� (0 newprojectinstance newProjectInstance
� FCPsFCPh
� FCPsFCPa�  0 focusonproject focusOnProject� 0 	focuslist 	focusList
� 
FCdw
� 
prdt
� 
FCFs
� .corecrel****      � null� *0 findthereplacements findTheReplacements� "0 thereplacements theReplacements
� 
rslt� 0 tempnote tempNote
� 
ret � 0 newnote newNote� $0 populatetemplate populateTemplate���*�,b   �)j+ E�O��,j &����lv�l� �,E�O��  )�k+ Y hY hO a a a l a ,Ec   W X  �a   hY hO +a �a a lv�l� �,E` O_ a  Ec  W X  �a   hY hOfEc  Y hO*a -a [a ,\Za @1j  E` !O*a -a [[a ,\Za "@\[a #,\Zf8A1j  j  �*a -a [a #,\Zf81E` $OjvE` %O T_ $[a &a 'l  kh a (E` )O�a *,a +,a ,  a -E` )Y hO_ )�a ,%E` )O_ )_ %6F[OY��O_ %a .a /a 0a 1a 2a 3a 4 5E` 6O_ 6f  hY hO)_ 6_ %fm+ 7E` 8O_ $a '_ 8/Ec  Y a 9Ec  Ob  a 9  =*a :-a [[[a ,,a ,\Za ;@\[a <,\Za =9A\[a <,\Za >9A1E` ?Y 8*a :-a [[[a ,,\Zb  8\[a <,\Za =9A\[a <,\Za >9A1E` ?OjvE` @O $_ ?[a &a 'l  kh �a ,_ @6F[OY��O_ @�,j  a Aj BOhY hOa CE` DOa EE` FOa GE` HO_ @a ._ Da 0_ Fa 2_ Ha 4 5E` IO_ If  hY hO)_ I_ @fm+ 7E` JO_ ?a '_ J/E` KO*a -a [[a ,\Za L@C\[a M,\Zf8A1E` NOa OkvE` PO T_ N[a &a 'l  kh a QE` )O�a *,a +,a ,  a RE` )Y hO_ )�a ,%E` )O_ )_ P6F[OY��OfE` SOjE` TO_ Ka U,b   �a VE` WO :_ Ka U,a X-j  kih _ Ka U,a X�/b   
�E` WY h[OY��O_ Ka U,a X_ W/E` YOb  b  a Z%lv)a [,FO_ Ya \-E` YOa ])a [,FO_ Ya ^&E` _O /k_ N�,Ekh _ __ Na '�/a , 
�E` TY h[OY��O_ Tj eE` SO_ Na '_ T/E` `Y hY hO)_ Kk+ aE` bOa cE` dO_ b�,j  Da e_ f%b   %a g%_ f%a h%�a ia jlv�l� B�,E` dO_ da k hY hY hO_ S �a lE` DOa mE` FOa nE` HO_ Pa ._ Da 0_ Fa 2_ Ha 4 5E` oO_ of  hY 9_ oa pkv  a qE` `Y #)_ o_ Pfm+ 7kE` TO_ Na '_ T/E` `Y hO_ da r  �_ `a s  _ Ka t*a u-6l vE` wY _ Ka t_ `a u-6l vE` wO_ wa <,a x  a y_ wa <,FY hOb   Ra z�a {a |lv�l� �,E` }O_ }a ~  +jvE` O_ w_ 6FO*a &a �a �a �_ l� �Y hY hOa �E` dOhY hO)_ bk+ �E` �O_ �f  hY hO_ `a �  _ Ka t*a u-6l vE` wY _ Ka t_ `a u-6l vE` wO_ wa <,a x  a y_ wa <,FY hO_ S �_ wa U,EQ` �O 8_ Ka U,a X-j  kih _ �a X�/b   
�E` WY hO[OY��O_ �kv)a [,FO_ Wk  _ �[a X\[Zl\Zi2a ^&E` �Y c_ W_ Ka U,a X-j    _ �[a X\[Zk\Za V2a ^&E` �Y 1_ �[a X\[Zk\Z_ Wk2_ �[a X\[Z_ Wk\Zi2%a ^&E` �Oa �)a [,FO_ �_ wa U,FY hO)_ w_ b_ �m+ �Ob   Ra ��a �a �lv�l� �,E` }O_ }a �  +jvE` O_ w_ 6FO*a &a �a �a �_ l� �Y hY hUU ascr  ��ޭ