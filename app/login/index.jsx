import React from "react";
import { View, Text, TextInput, TouchableOpacity, StyleSheet, Image } from "react-native";
import { FontAwesome } from "@expo/vector-icons";
import { useRouter } from "expo-router";
import Colors from "../../constant/Colors";

export default function Login() {
    const router = useRouter()

    return (
        <View style={styles.container}>
            {/* Logo */}
            <Image source={require("../assets/Symbol.png")} style={styles.logo} />

            {/* Title */}
            <Text style={styles.title}>Welcome Back!</Text>
            <Text style={styles.subtitle}>Login to continue</Text>

            {/* Input */}
            <TextInput
                style={styles.input}
                placeholder="Email or Phone"
                placeholderTextColor="#aaa"
                keyboardType="email-address"
            />

            {/* Login Button */}
            <TouchableOpacity style={styles.loginButton}
            onPress={()=>router.push('login/code')}
            >
                <Text style={styles.loginButtonText}>Login</Text>
            </TouchableOpacity>

            {/* Google Login Button */}
            <TouchableOpacity style={styles.googleButton}>
                <FontAwesome name="google" size={20} color="white" style={styles.googleIcon} />
            </TouchableOpacity>

            {/* Sign Up Button */}
            <TouchableOpacity>
                <Text style={styles.signupText}>Don't have an account? Sign up</Text>
            </TouchableOpacity>
        </View>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: "center",
        alignItems: "center",
        backgroundColor: Colors.PRIMARY,
        padding: 20,
    },
    logo: {
        width: 150,
        height: 150,
        marginBottom: 50,
        resizeMode: "contain",
    },
    title: {
        fontSize: 32,
        fontWeight: "bold",
        color: "#2e2e2e",
        marginBottom: 10,
    },
    subtitle: {
        fontSize: 18,
        color: "#2e2e2e",
        marginBottom: 40,
    },
    input: {
        width: "100%",
        backgroundColor: Colors.FIELD,
        color: "#fff",
        fontSize: 16,
        padding: 15,
        borderRadius: 8,
        marginBottom: 20,
        borderWidth: 1,
        borderColor: "#808080",
    },
    loginButton: {
        width: "100%",
        backgroundColor: Colors.BUTTON,
        padding: 15,
        borderRadius: 8,
        alignItems: "center",
        marginBottom: 20,
    },
    loginButtonText: {
        fontSize: 16,
        fontWeight: Colors.PRIMARY,
        color: "#fff",
    },
    googleButton: {
        flexDirection: "row",
        alignItems: "center",
        width: "100%",
        backgroundColor: Colors.BUTTON,
        padding: 15,
        borderRadius: 8,
        justifyContent: "center",
        marginBottom: 20,
    },
    googleIcon: {
        marginRight: 10,
    },
    googleButtonText: {
        fontSize: 16,
        fontWeight: "bold",
        color: "#fff",
    },
    signupText: {
        fontSize: 14,
        color: "#aaa",
        marginTop: 10,
        textDecorationLine: "underline",
    },});
