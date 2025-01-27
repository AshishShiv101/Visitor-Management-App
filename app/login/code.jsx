import React, { useState } from "react";
import {
    View,
    Text,
    TextInput,
    TouchableOpacity,
    StyleSheet,
    Alert,
    Dimensions
} from "react-native";
import Colors from "../../constant/Colors";
import { useRouter } from "expo-router";
import { LinearGradient } from "expo-linear-gradient";
import { FontAwesome } from "@expo/vector-icons";

const { height } = Dimensions.get('window');

export default function Code() {
    const router = useRouter();
    const [code, setCode] = useState("");

    const handleCodeChange = (text) => {
        if (text.length <= 6) {
            setCode(text.replace(/[^0-9]/g, ""));
        }
    };

    const handleSubmit = () => {
        if (code.length === 6) {
            router.push('(tabs)');
        } else {
            Alert.alert("Error", "Please enter a valid 6-digit code.");
        }
    };

    return (
        <View style={styles.mainContainer}>
            <LinearGradient
                colors={[Colors.PRIMARY, Colors.BUTTON]}
                start={{ x: 0, y: 0 }}
                end={{ x: 1, y: 1 }}
                style={styles.gradientContainer}
            >
                <View style={styles.patternOverlay} />

                {/* Title */}
                <Text style={styles.title}>Verification Code</Text>
                <Text style={styles.subtitle}>Enter the code to continue</Text>
            </LinearGradient>

            {/* Card Container */}
            <View style={styles.cardContainer}>
                <View style={styles.card}>
                    <Text style={styles.inputLabel}>
                        Please enter the preset 6-digit code
                    </Text>

                    <TextInput
                        style={styles.input}
                        value={code}
                        onChangeText={handleCodeChange}
                        placeholder="Enter 6-digit code"
                        placeholderTextColor="#aaa"
                        keyboardType="numeric"
                        maxLength={6}
                    />

                    <TouchableOpacity
                        style={styles.submitButton}
                        onPress={handleSubmit}
                    >
                        <Text style={styles.submitButtonText}>Submit</Text>
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
        fontWeight: "700",
        color: "#333",
        marginBottom: 8,
        textAlign: 'center',
        width: '100%',
    },
    input: {
        width: "100%",
        backgroundColor: Colors.FIELD,
        color: "#000",
        fontSize: 18,
        padding: 15,
        borderRadius: 8,
        marginBottom: 20,
        borderWidth: 1,
        borderColor: "#808080",
        textAlign: "center",
        letterSpacing: 2,
    },
    submitButton: {
        width: "100%",
        backgroundColor: Colors.BUTTON,
        padding: 15,
        borderRadius: 8,
        flexDirection: "row",
        alignItems: "center",
        justifyContent: "space-between",
        marginBottom: 20,
    },
    submitButtonText: {
        fontSize: 16,
        fontWeight: "bold",
        color: "#fff",
    },
    arrowIcon: {
        marginLeft: 10,
    },
});