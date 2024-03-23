import mongoose from 'mongoose';

mongoose.connect('mongodb+srv://danluck001:maxpayne5@cluster0.qkvb6c9.mongodb.net/', {
//   useNewUrlParser: true,
//   useUnifiedTopology: true,
});

export default mongoose.connection;

