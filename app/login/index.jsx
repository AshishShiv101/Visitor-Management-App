import React from "react";
import {
    View,
    Text,
    TextInput,
    TouchableOpacity,
    StyleSheet,
    Image,
    Dimensions,
} from "react-native";
import { FontAwesome } from "@expo/vector-icons";
import { LinearGradient } from "expo-linear-gradient";
import { useRouter } from "expo-router";
import Colors from "../../constant/Colors";

const { height } = Dimensions.get('window');

export default function Login() {
    const router = useRouter();

    return (
        <View style={styles.mainContainer}>
            <LinearGradient
                colors={[Colors.PRIMARY, Colors.BUTTON]}
                start={{ x: 0, y: 0 }}
                end={{ x: 1, y: 1 }}
                style={styles.gradientContainer}
            >
                <View style={styles.patternOverlay} />

                {/* Logo */}
                <Image source={require("../assets/Symbol.png")} style={styles.logo} />

                {/* Title */}
                <Text style={styles.title}>Welcome Back!</Text>
                <Text style={styles.subtitle}>Login to continue</Text>
            </LinearGradient>

            {/* Card Container */}
            <View style={styles.cardContainer}>
                <View style={styles.card}>
                    <Text style={styles.inputLabel}>Enter your email or phone number</Text>
                    <TextInput
                        style={styles.input}
                        placeholder="Email or Phone"
                        placeholderTextColor="#aaa"
                        keyboardType="email-address"
                    />

                    <TouchableOpacity
                        style={styles.loginButton}
                        onPress={() => router.push("login/code")}
                    >
                        <Text style={styles.loginButtonText}>Login</Text>
                        <FontAwesome
                            name="arrow-right"
                            size={18}
                            color="#fff"
                            style={styles.arrowIcon}
                        />
                    </TouchableOpacity>
                </View>
            </View>
        </View>
    );
}

const styles = StyleSheet.create({
    mainContainer: {
        flex: 1,
        backgroundColor: '#fff',
    },
    gradientContainer: {
        height: height * 0.65,
        justifyContent: "center",
        alignItems: "center",
        padding: 20,
        borderBottomLeftRadius: 30,
        borderBottomRightRadius: 30,
    },
    patternOverlay: {
        position: "absolute",
        top: 0,
        left: 0,
        right: 0,
        bottom: 0,
        opacity: 0.15,
        backgroundColor: "#fff",
        borderRadius: 150,
        width: "100%",
        height: "100%",
        transform: [{ rotate: "45deg" }],
    },
    logo: {
        marginTop: 50,
        width: 150,
        height: 150,
        marginBottom: 30,
        resizeMode: "contain",
    },
    title: {
        fontSize: 32,
        fontWeight: "bold",
        color: "#fff",
        marginBottom: 10,
    },
    subtitle: {
        fontSize: 18,
        color: "#fff",
        marginBottom: 40,
    },
    cardContainer: {
        flex: 1,
        backgroundColor: '#fff',
        marginTop: -50,
        borderTopLeftRadius: 30,
        borderTopRightRadius: 30,
    },
    card: {
        marginTop: 10,
        backgroundColor: '#fff',
        borderTopLeftRadius: 30,
        borderTopRightRadius: 100,
        padding: 20,
        height: 200,
    },
    inputLabel: {
        fontSize: 16,
        fontWeight: "700",  // Changed from "500" to "700" for bolder text
        color: "#333",
        marginBottom: 8,
        textAlign: 'center',  // Added to center align the text
        width: '100%',  // Added to ensure full width for center alignment
    },
    input: {
        width: "100%",
        backgroundColor: Colors.FIELD,
        color: "#000",
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
        flexDirection: "row",
        alignItems: "center",
        justifyContent: "space-between",
        marginBottom: 20,
    },
    loginButtonText: {
        fontSize: 16,
        fontWeight: "bold",
        color: "#fff",
    },
    arrowIcon: {
        marginLeft: 10,
    },
});