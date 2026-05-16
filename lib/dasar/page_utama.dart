import 'package:flutter/material.dart';
import 'package:hello_word/pages/MAPS/page_maps.dart';
import 'package:hello_word/pages/kisikisiuts/page_hospital.dart';
import 'package:hello_word/pages/page_gambar1.dart';
import 'package:hello_word/pages/page_gambar2.dart';
import 'package:hello_word/pages/page_listview.dart';
import 'package:hello_word/pages/page_movie_grid.dart';
import 'package:hello_word/pages/page_photos_json.dart';
import 'package:hello_word/pages/page_row_column.dart';
import 'package:hello_word/pages/page_simple_form.dart';
import 'package:hello_word/pages/page_stack.dart';
import 'package:hello_word/pages/page_users_json.dart';

class PageUtama extends StatelessWidget {
  const PageUtama({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MI 2 A PNP",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),

        ),
        backgroundColor: Colors.purpleAccent,
      ),

      drawer: SizedBox(
        width: 250,
        child: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(accountName: Text("Haifa"),
                accountEmail: Text("haifa@gmail.com"),
              currentAccountPicture: CircleAvatar(
                radius: 55,
                child: Icon(
                Icons.person,
                color: Colors.green,
                size: 65,
              ),
            ),
              ),

              ListTile(
                title: Text("Photo 1"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> PageGambar1())
                  );
                },
              ),

              ListTile(
                title: Text("Photo 2"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> PageGambar2())
                  );
                },
              )
            ],
          ),
        ),
      ),

      body: Center(
        child: Container(
          width: double.infinity, //lebih fleksibel
          height: double.infinity,
          margin: EdgeInsets.all(20), //atas kanan kiri bawah
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.purpleAccent,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            children: [
              Text(
                  'Selamat Datang di Apps Pertama MI 2A by Haifa Hafitriyanti',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black
              ),
              ),

              SizedBox(height: 10,),
              MaterialButton(
                color: Colors.greenAccent,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> PageStack())); //dari class A ke class B
                },
                child: Text('Page Stack'),
              ),

              SizedBox(height: 10,),
              MaterialButton(
                color: Colors.orangeAccent,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> PageRowColumn())); //dari class A ke class B
                },
                child: Text('Page Row'),
              ),

              SizedBox(height: 10,),
              MaterialButton(
                color: Colors.greenAccent,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> PageColumn())); //dari class A ke class B
                },
                child: Text('Page Column'),
              ),

              SizedBox(height: 10,),
              MaterialButton(
                color: Colors.yellow,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> PageListview())); //dari class A ke class B
                },
                child: Text('Page List View'),
              ),

              SizedBox(height: 10,),
              MaterialButton(
                color: Colors.white70,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> PageSimpleForm())); //dari class A ke class B
                },
                child: Text('Page Simple Form'),
              ),

              SizedBox(height: 10,),
              MaterialButton(
                color: Colors.white70,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> PageMovieGrid())); //dari class A ke class B
                },
                child: Text('Page Movie'),
              ),

              SizedBox(height: 10,),
              MaterialButton(
                color: Colors.yellowAccent,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> PagePhotosJson())); //dari class A ke class B
                },
                child: Text('Page Photos'),
              ),

              SizedBox(height: 10,),
              MaterialButton(
                color: Colors.white70,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> PageUsersJson())); //dari class A ke class B
                },
                child: Text('Page Users'),
              ),

              SizedBox(height: 10,),
              MaterialButton(
                color: Colors.white70,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> PageMainMaps())); //dari class A ke class B
                },
                child: Text('Page Maps'),
              ),

              SizedBox(height: 10,),
              MaterialButton(
                color: Colors.white70,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> PageHospital())); //dari class A ke class B
                },
                child: Text('Kisi Kisi UTS'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
