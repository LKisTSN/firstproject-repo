var express = require("express");
const mongoose = require('mongoose');
const Blog = require('./node_modules/Models/Blog');

// express app
var app = express();

// connect to mondoDB
const dbURI = "mongodb+srv://jiggl3z:FlowerTra1n@nodeproj.esegr.mongodb.net/NodeProj?retryWrites=true&w=majority";
mongoose.connect(dbURI)
    .then ((result) => app.listen(3000))
    .catch((err) => console.log(err));

app.get('/add-blog', (req,res) => {
    const blog = new Blog({
        title: 'New Blog',
        snippet: 'about my new blog',
        body: 'details of my new blog'
    });

    blog.save()
    .then((result) => {
        res.send(result)
    })
    .catch((err) => {
        console.log(err)
    })
});

app.get('/all-blogs',(req,res) =>{
    Blog.find()
    .then((result) => {
        res.send(result);
    })
    .catch((err) => {
        console.log(err);
    })
})
    app.get('/single-blog', (req,res) =>{
        Blog.findById('622edcb3dfd12adc43e394f8')
        .then((result) => {
            res.send(result)
        })
        .catch((err) => {
            console.log(err);
        })
});