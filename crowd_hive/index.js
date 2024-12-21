const express = require("express");
const Web3 = require("web3");
const mongoose = require("mongoose");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");

// MongoDB Setup
mongoose.connect("mongodb://localhost:27017/crowdfunding")
    .then(() => console.log("Connected to MongoDB"))
    .catch(err => console.log(err));

const app = express();
const port = 3000;

// Middleware to parse JSON bodies
app.use(express.json());

// Define User Schema (for both Investors and Businesses)
const userSchema = new mongoose.Schema({
    username: { type: String, required: true, unique: true },
    email: { type: String, required: true, unique: true },
    password: { type: String, required: true }, // Store hashed password
    role: { type: String, required: true, enum: ["Investor", "Business"] }, // Differentiates user type
});

const User = mongoose.model("User", userSchema);

// Define Company Schema (MongoDB)
const companySchema = new mongoose.Schema({
    companyName: String,
    projectName: String,
    contractAmount: Number,
    deadline: Date,
    fundingCriteriaMet: { type: Boolean, default: false },
    isComplete: { type: Boolean, default: false },
});

const Company = mongoose.model("Company", companySchema);

// Define Advertisement Schema (MongoDB)
const advertisementSchema = new mongoose.Schema({
    companyId: { type: mongoose.Schema.Types.ObjectId, ref: "User", required: true },
    heading: { type: String, required: true },
    description: { type: String, required: true },
    endGoal: { type: String, required: true },
    expectedAmount: { type: Number, required: true },
    duration: { type: Number, required: true }, // Duration in days
    createdAt: { type: Date, default: Date.now },
});

const Advertisement = mongoose.model("Advertisement", advertisementSchema);

// === Signup Endpoint (for both Investors and Businesses) ===
app.post("/signup", async (req, res) => {
    const { username, email, password, role } = req.body;
    
    if (!["Investor", "Business"].includes(role)) {
        return res.status(400).json({ message: "Invalid role" });
    }

    try {
        const hashedPassword = await bcrypt.hash(password, 10);
        const user = new User({ username, email, password: hashedPassword, role });
        await user.save();

        res.status(201).json({ message: `${role} registered successfully!` });
    } catch (error) {
        res.status(500).json({ status: "error", message: error.message });
    }
});

// === Login Endpoint (for both Investors and Businesses) ===
app.post("/login", async (req, res) => {
    const { username, password, role } = req.body;

    try {
        const user = await User.findOne({ username, role });
        if (!user) return res.status(400).json({ message: `${role} not found` });

        const isPasswordValid = await bcrypt.compare(password, user.password);
        if (!isPasswordValid) return res.status(400).json({ message: "Invalid credentials" });

        const token = jwt.sign({ id: user._id, role: user.role }, "your-secret-key", { expiresIn: "1h" });
        res.json({ message: `${role} login successful`, token });
    } catch (error) {
        res.status(500).json({ status: "error", message: error.message });
    }
});

// === Endpoint for creating advertisements (POST) ===
app.post("/create-poste  r", async (req, res) => {
    console.log("Received request to /create-poster");
    const { companyId, heading, description, endGoal, expectedAmount, duration } = req.body;
    try {
        const advertisement = new Advertisement({ companyId, heading, description, endGoal, expectedAmount, duration });
        await advertisement.save();
        res.status(201).json({ message: "Poster created successfully", advertisement });
    } catch (error) {
        res.status(500).json({ status: "error", message: error.message });
    }
});

// === Endpoint to retrieve advertisements (GET) ===
app.get("/get-posters", async (req, res) => {
    try {
        const posters = await Advertisement.find().populate("companyId", "username email");
        res.json({ posters });
    } catch (error) {
        res.status(500).json({ status: "error", message: error.message });
    }
});

// === Other routes ===
// Route to register a company
app.post("/register-company", async (req, res) => {
    const { companyName, projectName, contractAmount, deadline } = req.body;
    const company = new Company({ companyName, projectName, contractAmount, deadline });

    try {
        await company.save();
        res.status(201).json({ message: "Company registered successfully", company });
    } catch (error) {
        res.status(500).json({ status: "error", message: error.message });
    }
});

// Start server
app.listen(port, () => {
    console.log(`Backend listening on port ${port}`);
});
