import React, { useState } from "react";
import { View, Text, TextInput, TouchableOpacity, StyleSheet, Alert } from "react-native";
import Colors from "../../constant/Colors";
import { useRouter } from "expo-router";

export default function Code() {
        const router = useRouter()
    
    const [code, setCode] = useState("");

    const handleCodeChange = (text) => {
        if (text.length <= 6) {
            setCode(text.replace(/[^0-9]/g, "")); 
        }
    };

    const handleSubmit = () => {
        if (code.length === 6) {
            Alert.alert("Success", "Code submitted successfully!");
        } else {
            Alert.alert("Error", "Please enter a valid 6-digit code.");
        }
    };

    return (
        <View style={styles.container}>
            {/* Title */}
            <Text style={styles.title}>Enter Verification Code</Text>
            <Text style={styles.subtitle}>
                Please enter the 6-digit code sent to your email or phone
            </Text>

            {/* 6-digit Code Input */}
            <TextInput
                style={styles.input}
                value={code}
                onChangeText={handleCodeChange}
                placeholder="Enter 6-digit code"
                placeholderTextColor="#aaa"
                keyboardType="numeric"
                maxLength={6} // This works as an additional layer of restriction
            />

            {/* Submit Button */}
            <TouchableOpacity style={styles.submitButton} onPress={() => router.push('(tabs)')}>
                <Text style={styles.submitButtonText}>Submit</Text>
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
    title: {
        fontSize: 26,
        fontWeight: "bold",
        color: Colors.BUTTON14141,
        marginBottom: 10,
    },
    subtitle: {
        fontSize: 16,
        color: Colors.BUTTON,
        textAlign: "center",
        marginBottom: 30,
    },
    input: {
        width: "100%",
        backgroundColor: Colors.FIELD,
        color: Colors.BUTTON,
        fontSize: 18,
        padding: 15,
        borderRadius: 8,
        marginBottom: 20,
        borderWidth: 1,
        borderColor: "#444",
        textAlign: "center",
    },
    submitButton: {
        width: "100%",
        backgroundColor: Colors.BUTTON,
        padding: 15,
        borderRadius: 8,
        alignItems: "center",
    },
    submitButtonText: {
        fontSize: 18,
        fontWeight: "bold",
        color: "#FFF",
    },
});
